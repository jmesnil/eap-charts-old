{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "eap73.appName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
eap73.appImage is the name of the application image that is built/deployed
*/}}
{{- define "eap73.appImage" -}}
{{ default (include "eap73.appName" .) .Values.image.name }}
{{- end -}}

{{/*
eap73.appImageStreamTag is image stream of of the application image that is built/deployed
*/}}
{{- define "eap73.appImageStreamTag" -}}
{{ include "eap73.appImage" . }}:{{ .Values.image.tag}}
{{- end -}}

{{/*
eap73.appBuilderImage corresponds to the imagestram for the application Builder image
*/}}
{{- define "eap73.appBuilderImage" -}}
{{ include "eap73.appImage" . }}-build-artifacts
{{- end }}

{{/*
eap73.eapBuilderImage corresponds to the imagestream for the EAP S2I Builder image.
It depends on the build.s2i.jdkVersion.
*/}}
{{- define "eap73.eapBuilderImage" -}}
{{- if eq .Values.build.s2i.jdk "8"  -}}
{{ .Values.build.s2i.jdk8.builderImageStream}}
{{- else -}}
{{ .Values.build.s2i.jdk11.builderImageStream}}
{{- end -}}
{{- end -}}

{{/*
eap73.eapRuntimeImage corresponds to the imagestream for the EAP S2I Runtime image.
It depends on the build.s2i.jdkVersion.
*/}}
{{- define "eap73.eapRuntimeImage" -}}
{{- if eq .Values.build.s2i.jdk "8"  -}}
{{ .Values.build.s2i.jdk8.runtimeImageStream}}
{{- else -}}
{{ .Values.build.s2i.jdk11.runtimeImageStream}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "eap73.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "eap73.labels" -}}
helm.sh/chart: {{ include "eap73.chart" . }}
{{ include "eap73.selectorLabels" . }}
app.kubernetes.io/version: {{ quote .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: eap
{{- end }}

{{/*
Selector labels
*/}}
{{- define "eap73.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}