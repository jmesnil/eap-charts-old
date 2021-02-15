{{/*
Expand the name of the chart.
*/}}
{{- define "common-eap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "common-eap.fullName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
common-eap.appBuilderImage corresponds to the imagestram for the application Builder image
*/}}
{{- define "common-eap.appBuilderImage" -}}
{{- include "common-eap.appName" . }}-build-artifacts
{{- end }}

{{/*
common-eap.builderImage corresponds to the name of the WildFly Builder Image
*/}}
{{- define "common-eap.builderImage" -}}
quay.io/wildfly/wildfly-centos7
{{- end }}

{{/*
common-eap.runtimeImage corresponds to the name of the WildFly Runtime Image
*/}}
{{- define "common-eap.runtimeImage" -}}
quay.io/wildfly/wildfly-runtime-centos7
{{- end }}

{{/*
If common-eap.version is not defined, use by defaul the Chart's appVersion
*/}}
{{- define "common-eap.version" -}}
{{- if .Values.eap -}}
{{- default .Chart.AppVersion .Values.eap.version -}}
{{- else -}}
{{- .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common-eap.appName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common-eap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common-eap.labels" -}}
helm.sh/chart: {{ include "common-eap.chart" . }}
{{ include "common-eap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: eap
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common-eap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common-eap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
