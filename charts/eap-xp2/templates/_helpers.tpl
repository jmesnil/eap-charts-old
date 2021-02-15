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
