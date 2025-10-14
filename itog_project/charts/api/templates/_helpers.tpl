{{- define "api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "api.fullname" -}}
{{- include "api.name" . -}}
{{- end -}}
