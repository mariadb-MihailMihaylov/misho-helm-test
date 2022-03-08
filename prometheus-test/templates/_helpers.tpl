{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-test.name" -}}
{{- default .Chart.Name .Values.default.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-test.fullname" -}}
{{- if .Values.default.fullnameOverride }}
{{- .Values.default.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.default.nameOverride }}
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
{{- define "prometheus-test.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prometheus-test.labels" -}}
helm.sh/chart: {{ include "prometheus-test.chart" . }}
{{ include "prometheus-test.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prometheus-test.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus-test.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus-test.serviceAccountName" -}}
{{- if .Values.default.serviceAccount.create }}
{{- default (include "prometheus-test.fullname" .) .Values.default.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.default.serviceAccount.name }}
{{- end }}
{{- end }}
