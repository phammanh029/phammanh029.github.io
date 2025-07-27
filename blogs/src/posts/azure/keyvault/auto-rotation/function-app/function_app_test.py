from datetime import datetime, timedelta, timezone
from unittest.mock import patch, MagicMock
import pytest

from function_app import kvrotation  # Your function file


class DummyEventGridEvent:
    def get_json(self):
        return {"Id": "https://myvault.vault.azure.net/secrets/my-secret/version123"}


@patch("function_app.datetime")  # Patch datetime in the function_app module
@patch("function_app.SecretClient")
@patch("function_app.DefaultAzureCredential")
def test_kvrotation_with_mocked_time(mock_cred, mock_client_class, mock_datetime):
    fake_now = datetime(2025, 1, 1, tzinfo=timezone.utc)
    mock_datetime.now.return_value = fake_now
    mock_datetime.side_effect = lambda *args, **kwargs: datetime(*args, **kwargs)
    mock_datetime.timezone = timezone  # Ensure timezone.utc works

    # Setup credential
    mock_cred.return_value = MagicMock()

    # Setup SecretClient and secret
    mock_secret = MagicMock()
    mock_secret.value = "test-secret"
    mock_secret.properties.content_type = "text/plain"

    mock_client = MagicMock()
    mock_client.get_secret.return_value = mock_secret
    mock_client_class.return_value = mock_client

    event = DummyEventGridEvent()
    kvrotation(event)

    expected_expiry = fake_now + timedelta(days=90)
    mock_client.set_secret.assert_called_once()
    actual_call = mock_client.set_secret.call_args.kwargs
    assert actual_call["expires_on"] == expected_expiry
