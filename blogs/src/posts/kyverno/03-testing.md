# Learn Kyverno: test policy decisions locally

The [Kyverno CLI](https://kyverno.io/docs/subprojects/kyverno-cli/) evaluates policies against local YAML. Install it using the official instructions and choose a version that supports the APIs in these lessons, ideally matching your cluster release.

```bash
kyverno version
mkdir kyverno-tests
cd kyverno-tests
```

Copy `require-team.yaml` from [lesson one](/post/kyverno/01-getting-started) into this directory. Save these fixtures as `pods.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: good
  namespace: kyverno-lab
  labels:
    team: backend
spec:
  containers:
    - name: web
      image: nginx:1.28
---
apiVersion: v1
kind: Pod
metadata:
  name: bad
  namespace: kyverno-lab
spec:
  containers:
    - name: web
      image: nginx:1.28
---
apiVersion: v1
kind: Pod
metadata:
  name: outside-lab
  namespace: default
spec:
  containers:
    - name: web
      image: nginx:1.28
```

Save this as `kyverno-test.yaml`:

```yaml
apiVersion: cli.kyverno.io/v1alpha1
kind: Test
metadata:
  name: require-team-examples
policies:
  - require-team.yaml
resources:
  - pods.yaml
results:
  - policy: lab-require-team
    isValidatingPolicy: true
    kind: Pod
    resources:
      - kyverno-lab/good
    result: pass
  - policy: lab-require-team
    isValidatingPolicy: true
    kind: Pod
    resources:
      - kyverno-lab/bad
    result: fail
  - policy: lab-require-team
    isValidatingPolicy: true
    kind: Pod
    resources:
      - default/outside-lab
    result: skip
```

```bash
kyverno test .
```

All three assertions should succeed: a compliant Pod passes, an unlabelled Pod fails, and another namespace is skipped. An expected policy `fail` is a successful test when the actual decision matches. CEL validation tests use `isValidatingPolicy: true`; see the [CLI testing examples](https://kyverno.io/docs/subprojects/kyverno-cli/#testing-validatingpolicies).

Change `team: backend` to `team: ''` in the first fixture. Run again: the test should now fail because its expected `pass` no longer matches. Restore the value and rerun.

## Separate local decisions from admission behavior

This test runs only validation. It does not execute the mutation policy from lesson two, install webhooks, schedule Pods, or prove a live cluster is configured correctly. Retain the live commands in those lessons as integration checks. The [testing guide](https://kyverno.io/docs/guides/testing-policies/) explains using fixtures in a delivery pipeline.

In a shared environment, begin with `validationActions: [Audit]`, inspect reports, fix violations, then switch to `[Deny]` when the policy is ready to enforce. Background reporting does not evict existing Pods. See [policy reports](https://kyverno.io/docs/guides/reports/) for reporting behavior.

## Clean up the learning resources

After finishing both live lessons:

```bash
kubectl delete validatingpolicy lab-require-team
kubectl delete mutatingpolicy lab-default-team
kubectl delete namespace kyverno-lab
```

The namespace deletion also deletes the lab Pods. Keep your local fixtures to test future policy edits.
