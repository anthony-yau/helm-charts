{{/*
Expand the name of the chart.
*/}}
{{- define "doris.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "doris.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 50 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 50 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 50 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "doris.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "doris.labels" -}}
helm.sh/chart: {{ include "doris.chart" . }}
{{ include "doris.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "doris.selectorLabels" -}}
app.kubernetes.io/name: {{ include "doris.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "doris.createConfigmap" -}}
{{- if empty .Values.existingConfigmap }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "doris.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.frontend.image .Values.backend.image .Values.volumePermissions.image .Values.sysctl.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper doris fe image name
*/}}
{{- define "doris.frontend.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.frontend.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper doris be image name
*/}}
{{- define "doris.backend.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.backend.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "doris.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return sysctl image
*/}}
{{- define "doris.sysctl.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.sysctl.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "doris.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the doris fe name
*/}}
{{- define "doris.frontend.name" -}}
{{ printf "%s-fe" (include "doris.fullname" .) | trunc 63 | trimSuffix "-"  }}
{{- end -}}

{{/*
Return the doris be name
*/}}
{{- define "doris.backend.name" -}}
{{ printf "%s-be" (include "doris.fullname" .) | trunc 63 | trimSuffix "-"  }}
{{- end -}}

{{/*
Return the doris be computation name
*/}}
{{- define "doris.backend-cn.name" -}}
{{ printf "%s-be-cn" (include "doris.fullname" .) | trunc 63 | trimSuffix "-"  }}
{{- end -}}