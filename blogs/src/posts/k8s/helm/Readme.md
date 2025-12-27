# Using Helm

## Helm comment

https://helm.sh/docs/chart_best_practices/templates/#comments-yaml-comments-vs-template-comments

Beware of adding # YAML comments on template sections containing Helm values that may be required by certain template functions.
Eg:
```yaml
# This may cause problems if the value is more than 100Gi
memory: {{ .Values.maxMem | quote }}

{{- /*
# This may cause problems if the value is more than 100Gi
memory: {{ required "maxMem must be set" .Values.maxMem | quote }}
*/ -}}
```