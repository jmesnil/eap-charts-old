
{{/*
eap73.eapBuilderImage corresponds to the imagestream for the EAP S2I Builder image.
It depends on the build.s2i.jdkVersion.
*/}}
{{- define "eap73.eapBuilderImage" -}}
{{- if eq .Values.build.s2i.jdk "8"  -}}
{{ .Values.build.s2i.jdk8.builderImage}}:latest
{{- else -}}
{{ .Values.build.s2i.jdk11.builderImage}}:latest
{{- end -}}
{{- end -}}

{{/*
eap73.eapRuntimeImage corresponds to the imagestream for the EAP S2I Runtime image.
It depends on the build.s2i.jdkVersion.
*/}}
{{- define "eap73.eapRuntimeImage" -}}
{{- if eq .Values.build.s2i.jdk "8"  -}}
{{ .Values.build.s2i.jdk8.runtimeImage}}:latest
{{- else -}}
{{ .Values.build.s2i.jdk11.runtimeImage}}:latest
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
{{ include "wildfly-common.selectorLabels" . }}
app.kubernetes.io/version: {{ quote .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: eap
{{- end }}

{{- define "eap73.metadata.labels" -}}
metadata:
  labels:
  {{- include "eap73.labels" . | nindent 4 }}
{{- end -}}