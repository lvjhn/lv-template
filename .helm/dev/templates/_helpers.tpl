{{/* returns simple app name */}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.appName -}}
{{- end -}}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
