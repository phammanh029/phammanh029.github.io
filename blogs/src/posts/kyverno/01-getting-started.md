# Learn Kyverno: your first policy

Kyverno lets you put Kubernetes rules into policies: require labels, add defaults, generate resources, or verify container images. For this lab, imagine a team wants every Pod to identify its owner using a `team` label.

Read this series in order:

1. Your first validation policy (this post).
2. [Add defaults with mutation](/post/kyverno/02-mutation).
3. [Test policies locally](/post/kyverno/03-testing).

## Prepare a lab

Use a disposable Kubernetes cluster, `kubectl`, Helm, and permission to install CRDs and controllers. Check the selected release's [Kubernetes compatibility and installation instructions](https://kyverno.io/docs/installation/installation/).

```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno --namespace kyverno --create-namespace --wait
kubectl get pods -n kyverno
kubectl create namespace kyverno-lab
```

This follows the [official quick start](https://kyverno.io/docs/introduction/quick-start/) for a learning installation. Record the installed versions with `helm list -n kyverno`; pin the chart version when repeating the lab.

These examples use the current CEL-based `policies.kyverno.io/v1` APIs. Older tutorials often use `kyverno.io/v1` `ClusterPolicy`, which the current documentation marks deprecated. Check that your installation serves the APIs before continuing:

```bash
kubectl explain validatingpolicy --api-version=policies.kyverno.io/v1
kubectl explain mutatingpolicy --api-version=policies.kyverno.io/v1
```

If either fails, compare your release with its versioned documentation rather than changing only the YAML's API version.

## Require a team label

Save this as `require-team.yaml`:

```yaml
apiVersion: policies.kyverno.io/v1
kind: ValidatingPolicy
metadata:
  name: lab-require-team
spec:
  validationActions: [Deny]
  matchConstraints:
    resourceRules:
      - apiGroups: ['']
        apiVersions: [v1]
        operations: [CREATE, UPDATE]
        resources: [pods]
  matchConditions:
    - name: learning-namespace
      expression: "object.metadata.namespace == 'kyverno-lab'"
  validations:
    - message: 'Set a non-empty team label on the Pod.'
      expression: "has(object.metadata.labels) && has(object.metadata.labels.team) && object.metadata.labels.team != ''"
```

Read it in three steps: select Pod creation and updates, restrict evaluation to `kyverno-lab`, then require a non-empty label. `has()` checks missing fields; the expression must evaluate to true. `Deny` blocks a matching request that fails validation. See the [ValidatingPolicy reference](https://kyverno.io/docs/policy-types/validating-policy/).

```bash
kubectl apply -f require-team.yaml
kubectl get validatingpolicy lab-require-team -o yaml
```

Inspect the policy status and wait for readiness before trying the examples.

## See a rejection and an acceptance

```bash
# Expected: rejected with the policy's message.
kubectl run no-team -n kyverno-lab --image=nginx:1.28 --restart=Never

# Expected: accepted.
kubectl run backend -n kyverno-lab --image=nginx:1.28 --restart=Never --labels=team=backend
kubectl get pod backend -n kyverno-lab --show-labels
```

Acceptance means the API stored the Pod. Image pulls or scheduling can still fail separately.

Try `--labels=team=` on a new Pod: an empty label should also be rejected. A Pod in another namespace is outside this example's scope.

For a Deployment, labels on the Deployment itself and labels under `spec.template.metadata.labels` are different. The latter belong to its Pods. Controller auto-generation varies with policy configuration; start with direct Pods to make the outcome clear.

Leave the validation policy installed for [the mutation lesson](/post/kyverno/02-mutation).
