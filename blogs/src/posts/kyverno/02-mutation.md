# Learn Kyverno: add defaults with mutation

Complete [the first lesson](/post/kyverno/01-getting-started) first. Its policy rejects Pods without a `team` label. Now add a default so users can omit that label.

Mutation changes an incoming resource before validation checks it. Our rule will supply `team=platform` only when the label is absent. It will preserve an explicit owner. This uses the [MutatingPolicy API](https://kyverno.io/docs/policy-types/mutating-policy/).

Save as `default-team.yaml`:

```yaml
apiVersion: policies.kyverno.io/v1
kind: MutatingPolicy
metadata:
  name: lab-default-team
spec:
  evaluation:
    admission:
      enabled: true
    mutateExisting:
      enabled: false
  matchConstraints:
    resourceRules:
      - apiGroups: ['']
        apiVersions: [v1]
        operations: [CREATE, UPDATE]
        resources: [pods]
  matchConditions:
    - name: learning-namespace
      expression: "object.metadata.namespace == 'kyverno-lab'"
    - name: team-is-missing
      expression: '!has(object.metadata.labels) || !has(object.metadata.labels.team)'
  mutations:
    - patchType: ApplyConfiguration
      applyConfiguration:
        expression: >
          Object{
            metadata: Object.metadata{
              labels: Object.metadata.labels{
                team: "platform"
              }
            }
          }
```

The condition decides whether to run; the CEL `Object` expression builds the patch. Existing resources are not automatically changed because `mutateExisting` is disabled.

```bash
kubectl apply -f default-team.yaml
kubectl get mutatingpolicy lab-default-team -o yaml
```

Inspect status for readiness. Then try these cases with the validation policy still installed:

```bash
kubectl run defaulted -n kyverno-lab --image=nginx:1.28 --restart=Never
kubectl get pod defaulted -n kyverno-lab -o jsonpath='{.metadata.labels.team}{"\n"}'

kubectl run explicit -n kyverno-lab --image=nginx:1.28 --restart=Never --labels=team=payments
kubectl get pod explicit -n kyverno-lab -o jsonpath='{.metadata.labels.team}{"\n"}'

kubectl run empty-team -n kyverno-lab --image=nginx:1.28 --restart=Never --labels=team=
```

| Input | Mutation | Validation | Expected result |
| --- | --- | --- | --- |
| Label absent | Adds `platform` | Pass | Pod accepted |
| `team=payments` | Skips | Pass | Owner preserved |
| `team=` | Skips | Fail | Request rejected |

An empty string is present, so the missing-label condition skips it. This distinction is intentional: the policy fills an omission without silently correcting an invalid explicit value.

As an exercise, change the mutation condition to also match empty strings. Predict the third outcome before retrying with a new Pod name.

Next: [test policy decisions without a cluster](/post/kyverno/03-testing).
