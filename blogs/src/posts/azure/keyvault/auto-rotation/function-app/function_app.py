import logging
import os
from datetime import datetime, timedelta, timezone

from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import azure.functions as func

app = func.FunctionApp()

@app.event_grid_trigger(arg_name="azeventgrid")
def kvrotation(azeventgrid: func.EventGridEvent):
    """
    Azure Function to handle Key Vault secret rotation triggered by Event Grid events.
    """
    event_data = azeventgrid.get_json()
    secret_id: str | None = event_data.get("Id")

    if not secret_id:
        logging.error("Secret ID is missing in the event payload.")
        return

    # Extract vault URL and secret name
    try:
        vault_url, secret_path = secret_id.split("/secrets/")
        secret_name = secret_path.split("/")[0]
    except (ValueError, IndexError):
        logging.error(f"Invalid secret ID format: {secret_id}")
        return

    logging.info(f"Parsed Vault URL: {vault_url}")
    logging.info(f"Parsed Secret Name: {secret_name}")

    # Fetch rotation period
    try:
        rotation_days = int(os.getenv("ROTATION_DAYS", "90"))
    except ValueError:
        logging.warning("ROTATION_DAYS is not a valid integer. Defaulting to 90.")
        rotation_days = 90

    # Initialize Key Vault client
    try:
        credential = DefaultAzureCredential()
        client = SecretClient(vault_url=vault_url, credential=credential)
    except Exception as e:
        logging.exception(f"Failed to initialize SecretClient. {e}")
        return

    # Perform secret rotation
    try:
        secret = client.get_secret(secret_name)
        new_expiry = datetime.now(timezone.utc) + timedelta(days=rotation_days)

        client.set_secret(
            name=secret_name,
            value=secret.value,
            expires_on=new_expiry,
            content_type=secret.properties.content_type
        )

        logging.info(f"Secret '{secret_name}' rotated. New expiry: {new_expiry.isoformat()}")
    except Exception as e:
        logging.exception(f"Secret rotation failed: {e}")
