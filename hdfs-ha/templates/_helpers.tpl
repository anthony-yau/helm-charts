{{/*
Expand the name of the chart.
*/}}
{{- define "hdfs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hdfs.fullname" -}}
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
{{- define "hdfs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hdfs.labels" -}}
helm.sh/chart: {{ include "hdfs.chart" . }}
{{ include "hdfs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hdfs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hdfs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "hdfs.createConfigmap" -}}
{{- if empty .Values.existingConfigmap }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "hdfs.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image .Values.sysctl.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper hdfs image name
*/}}
{{- define "hdfs.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "hdfs.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return sysctl image
*/}}
{{- define "hdfs.sysctl.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.sysctl.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hdfs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the namenode0 hostname
*/}}
{{- define "hdfs.namenode.hostname0" -}}
    {{- printf "%s-namenode" (include "hdfs.fullname" .) }}-0.{{ printf "%s-nm-headless" (include "hdfs.fullname" .) | trunc 63 | trimSuffix "-"  }}.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end -}}

{{/*
Create the name of the namenode1 hostname
*/}}
{{- define "hdfs.namenode.hostname1" -}}
    {{- printf "%s-namenode" (include "hdfs.fullname" .) }}-1.{{ printf "%s-nm-headless" (include "hdfs.fullname" .) | trunc 63 | trimSuffix "-"  }}.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end -}}

{{/*
Create the name of the journalnode0 hostname
*/}}
{{- define "hdfs.journalnode.hostname0" -}}
    {{ printf "%s-journalnode" (include "hdfs.fullname" .) }}-0.{{ printf "%s-jn-headless" (include "hdfs.fullname" .) | trunc 63 | trimSuffix "-"  }}.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end -}}

{{/*
Create the name of the journalnode1 hostname
*/}}
{{- define "hdfs.journalnode.hostname1" -}}
    {{ printf "%s-journalnode" (include "hdfs.fullname" .) }}-1.{{ printf "%s-jn-headless" (include "hdfs.fullname" .) | trunc 63 | trimSuffix "-"  }}.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end -}}

{{/*
Create the name of the journalnode2 hostname
*/}}
{{- define "hdfs.journalnode.hostname2" -}}
    {{ printf "%s-journalnode" (include "hdfs.fullname" .) }}-2.{{ printf "%s-jn-headless" (include "hdfs.fullname" .) | trunc 63 | trimSuffix "-"  }}.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end -}}
