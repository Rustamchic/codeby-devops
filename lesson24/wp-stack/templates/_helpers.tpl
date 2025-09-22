cat > templates/_helpers.tpl <<'TPL'
{{- define "wp-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wp-stack.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "wp-stack.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "wp-stack.labels" -}}
app.kubernetes.io/name: {{ include "wp-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- if .Values.commonLabels }}
{{- range $k, $v := .Values.commonLabels }}
{{ $k }}: {{ $v | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "wp-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wp-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "wp-stack.mysql.fullname" -}}
{{ include "wp-stack.fullname" . }}-mysql
{{- end -}}

{{- define "wp-stack.wordpress.fullname" -}}
{{ include "wp-stack.fullname" . }}-wordpress
{{- end -}}

{{- define "wp-stack.wordpress.pvcName" -}}
{{ include "wp-stack.wordpress.fullname" . }}-data
{{- end -}}
TPL
