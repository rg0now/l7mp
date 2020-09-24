{{/*
Expand the name of the chart.
*/}}
{{- define "arch-v5.name" -}}
{{- default .Chart.Name .values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "arch-v5.fullname" -}}
{{- if .values.fullnameOverride }}
{{- .values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "arch-v5.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "arch-v5.labels" -}}
helm.sh/chart: {{ include "arch-v5.chart" . }}
{{ include "arch-v5.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "arch-v5.selectorLabels" -}}
app.kubernetes.io/name: {{ include "arch-v5.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "arch-v5.serviceAccountName" -}}
{{- if .values.serviceAccount.create }}
{{- default (include "arch-v5.fullname" .) .values.serviceAccount.name }}
{{- else }}
{{- default "default" .values.serviceAccount.name }}
{{- end }}
{{- end }}
