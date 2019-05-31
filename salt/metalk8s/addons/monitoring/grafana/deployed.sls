#!jinja | kubernetes kubeconfig=/etc/kubernetes/admin.conf&context=kubernetes-admin@kubernetes

{%- from "metalk8s/repo/macro.sls" import build_image_name with context %}

# The content below has been generated from
# https://github.com/coreos/prometheus-operator, v0.29.0 tag,
# with the following command:
#   hack/concat-kubernetes-manifests.sh $(find contrib/kube-prometheus/manifests/ \
#     -name "grafana-*.yaml") > deployed.sls
# In the following, only container image registries have been replaced.

---
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  labels:
    app: grafana
  name: grafana
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - image: {{ build_image_name('grafana', '6.0.0') }}
        name: grafana
        ports:
        - containerPort: 3000
          name: http
        readinessProbe:
          httpGet:
            path: /api/health
            port: http
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi
        volumeMounts:
        - mountPath: /var/lib/grafana
          name: grafana-storage
          readOnly: false
        - mountPath: /etc/grafana/provisioning/datasources
          name: grafana-datasources
          readOnly: false
        - mountPath: /etc/grafana/provisioning/dashboards
          name: grafana-dashboards
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/k8s-cluster-rsrc-use
          name: grafana-dashboard-k8s-cluster-rsrc-use
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/k8s-node-rsrc-use
          name: grafana-dashboard-k8s-node-rsrc-use
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/k8s-resources-cluster
          name: grafana-dashboard-k8s-resources-cluster
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/k8s-resources-namespace
          name: grafana-dashboard-k8s-resources-namespace
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/k8s-resources-pod
          name: grafana-dashboard-k8s-resources-pod
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/nodes
          name: grafana-dashboard-nodes
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/persistentvolumesusage
          name: grafana-dashboard-persistentvolumesusage
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/pods
          name: grafana-dashboard-pods
          readOnly: false
        - mountPath: /grafana-dashboard-definitions/0/statefulset
          name: grafana-dashboard-statefulset
          readOnly: false
      nodeSelector:
        beta.kubernetes.io/os: linux
        node-role.kubernetes.io/infra: ''
      securityContext:
        runAsNonRoot: true
        runAsUser: 65534
      serviceAccountName: grafana
      volumes:
      - emptyDir: {}
        name: grafana-storage
      - ConfigMap:
          name: grafana-datasources
        name: grafana-datasources
      - configMap:
          name: grafana-dashboards
        name: grafana-dashboards
      - configMap:
          name: grafana-dashboard-k8s-cluster-rsrc-use
        name: grafana-dashboard-k8s-cluster-rsrc-use
      - configMap:
          name: grafana-dashboard-k8s-node-rsrc-use
        name: grafana-dashboard-k8s-node-rsrc-use
      - configMap:
          name: grafana-dashboard-k8s-resources-cluster
        name: grafana-dashboard-k8s-resources-cluster
      - configMap:
          name: grafana-dashboard-k8s-resources-namespace
        name: grafana-dashboard-k8s-resources-namespace
      - configMap:
          name: grafana-dashboard-k8s-resources-pod
        name: grafana-dashboard-k8s-resources-pod
      - configMap:
          name: grafana-dashboard-nodes
        name: grafana-dashboard-nodes
      - configMap:
          name: grafana-dashboard-persistentvolumesusage
        name: grafana-dashboard-persistentvolumesusage
      - configMap:
          name: grafana-dashboard-pods
        name: grafana-dashboard-pods
      - configMap:
          name: grafana-dashboard-statefulset
        name: grafana-dashboard-statefulset
      tolerations:
      - key: "node-role.kubernetes.io/bootstrap"
        operator: "Exists"
        effect: "NoSchedule"
      - key: "node-role.kubernetes.io/infra"
        operator: "Exists"
        effect: "NoSchedule"
---
{%- raw %}
apiVersion: v1
items:
- apiVersion: v1
  data:
    k8s-cluster-rsrc-use.json: |-
      {
          "annotations": {
              "list": [

              ]
          },
          "editable": true,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "links": [

          ],
          "refresh": "10s",
          "rows": [
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 1,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:cluster_cpu_utilisation:ratio",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 2,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_cpu_saturation_load1: / scalar(sum(min(kube_pod_info) by (node)))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Saturation (Load1)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 3,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:cluster_memory_utilisation:ratio",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 4,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_memory_swap_io_bytes:sum_rate",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Saturation (Swap I/O)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 5,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_disk_utilisation:avg_irate / scalar(:kube_pod_info_node_count:)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk IO Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 6,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_disk_saturation:avg_irate / scalar(:kube_pod_info_node_count:)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk IO Saturation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Disk",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 7,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_net_utilisation:sum_irate",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Net Utilisation (Transmitted)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 8,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_net_saturation:sum_irate",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Net Saturation (Dropped)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Network",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 9,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(max(node_filesystem_size_bytes{fstype=\u007e\"ext[234]|btrfs|xfs|zfs\"} - node_filesystem_avail_bytes{fstype=\u007e\"ext[234]|btrfs|xfs|zfs\"}) by (device,pod,namespace)) by (pod,namespace)\n/ scalar(sum(max(node_filesystem_size_bytes{fstype=\u007e\"ext[234]|btrfs|xfs|zfs\"}) by (device,pod,namespace)))\n* on (namespace, pod) group_left (node) node_namespace_pod:kube_pod_info:\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{node}}",
                                  "legendLink": "/d/4ac4f123aae0ff6dbaf4f4f66120033b/k8s-node-rsrc-use",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk Capacity",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 1,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Storage",
                  "titleSize": "h6"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / USE Method / Cluster",
          "uid": "a6e7d1362e1ddbb79db21d5bb40d7137",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-k8s-cluster-rsrc-use
    namespace: monitoring
- apiVersion: v1
  data:
    k8s-node-rsrc-use.json: |-
      {
          "annotations": {
              "list": [

              ]
          },
          "editable": true,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "links": [

          ],
          "refresh": "10s",
          "rows": [
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 1,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_cpu_utilisation:avg1m{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Utilisation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 2,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_cpu_saturation_load1:{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Saturation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Saturation (Load1)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 3,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_memory_utilisation:{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Memory",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 4,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_memory_swap_io_bytes:sum_rate{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Swap IO",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Saturation (Swap I/O)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 5,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_disk_utilisation:avg_irate{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Utilisation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk IO Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 6,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_disk_saturation:avg_irate{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Saturation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk IO Saturation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Disk",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 7,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_net_utilisation:sum_irate{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Utilisation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Net Utilisation (Transmitted)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 8,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_net_saturation:sum_irate{node=\"$node\"}",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Saturation",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Net Saturation (Dropped)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "Bps",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Net",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 9,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_filesystem_usage:\n* on (namespace, pod) group_left (node) node_namespace_pod:kube_pod_info:{node=\"$node\"}\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{device}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Disk",
                  "titleSize": "h6"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {
                          "text": "prod",
                          "value": "prod"
                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "node",
                      "multi": false,
                      "name": "node",
                      "options": [

                      ],
                      "query": "label_values(kube_node_info, node)",
                      "refresh": 1,
                      "regex": "",
                      "sort": 2,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / USE Method / Node",
          "uid": "4ac4f123aae0ff6dbaf4f4f66120033b",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-k8s-node-rsrc-use
    namespace: monitoring
- apiVersion: v1
  data:
    k8s-resources-cluster.json: |-
      {
          "annotations": {
              "list": [

              ]
          },
          "editable": true,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "links": [

          ],
          "refresh": "10s",
          "rows": [
              {
                  "collapse": false,
                  "height": "100px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 1,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "1 - avg(rate(node_cpu_seconds_total{mode=\"idle\"}[1m]))",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 2,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_cpu_cores) / sum(node:node_num_cpu:sum)",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Requests Commitment",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 3,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_cpu_cores) / sum(node:node_num_cpu:sum)",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Limits Commitment",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 4,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "1 - sum(:node_memory_MemFreeCachedBuffers_bytes:sum) / sum(:node_memory_MemTotal_bytes:sum)",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Utilisation",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 5,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_memory_bytes) / sum(:node_memory_MemTotal_bytes:sum)",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Requests Commitment",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "format": "percentunit",
                          "id": 6,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 2,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_memory_bytes) / sum(:node_memory_MemTotal_bytes:sum)",
                                  "format": "time_series",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "70,80",
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Limits Commitment",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "singlestat",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Headlines",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 7,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate) by (namespace)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{namespace}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 8,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "CPU Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "CPU Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Namespace",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": true,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-namespace=$__cell",
                                  "pattern": "namespace",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_cpu_cores) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate) by (namespace) / sum(kube_pod_container_resource_requests_cpu_cores) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_cpu_cores) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate) by (namespace) / sum(kube_pod_container_resource_limits_cpu_cores) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Quota",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU Quota",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 9,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(container_memory_rss{container_name!=\"\"}) by (namespace)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{namespace}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Usage (w/o cache)",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "decbytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 10,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "Memory Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Memory Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Namespace",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": true,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-namespace=$__cell",
                                  "pattern": "namespace",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(container_memory_rss{container_name!=\"\"}) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_memory_bytes) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(container_memory_rss{container_name!=\"\"}) by (namespace) / sum(kube_pod_container_resource_requests_memory_bytes) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_memory_bytes) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(container_memory_rss{container_name!=\"\"}) by (namespace) / sum(kube_pod_container_resource_limits_memory_bytes) by (namespace)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Requests by Namespace",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory Requests",
                  "titleSize": "h6"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Compute Resources / Cluster",
          "uid": "efa86fd1d0c121a26444b636a3f509a8",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-k8s-resources-cluster
    namespace: monitoring
- apiVersion: v1
  data:
    k8s-resources-namespace.json: |-
      {
          "annotations": {
              "list": [

              ]
          },
          "editable": true,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "links": [

          ],
          "refresh": "10s",
          "rows": [
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 1,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\"}) by (pod_name)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{pod_name}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU Usage",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 2,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "CPU Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "CPU Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Pod",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": true,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-namespace=$namespace&var-pod=$__cell",
                                  "pattern": "pod",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_cpu_cores{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod) / sum(kube_pod_container_resource_requests_cpu_cores{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_cpu_cores{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod) / sum(kube_pod_container_resource_limits_cpu_cores{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Quota",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU Quota",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 3,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(container_memory_usage_bytes{namespace=\"$namespace\", container_name!=\"\"}) by (pod_name)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{pod_name}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "decbytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory Usage",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 4,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "Memory Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Memory Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Pod",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": true,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-namespace=$namespace&var-pod=$__cell",
                                  "pattern": "pod",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\",container_name!=\"\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_memory_bytes{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\",container_name!=\"\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod) / sum(kube_pod_container_resource_requests_memory_bytes{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_memory_bytes{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\",container_name!=\"\"}, \"pod\", \"$1\", \"pod_name\", \"(.*)\")) by (pod) / sum(kube_pod_container_resource_limits_memory_bytes{namespace=\"$namespace\"}) by (pod)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Quota",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory Quota",
                  "titleSize": "h6"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {
                          "text": "prod",
                          "value": "prod"
                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "namespace",
                      "multi": false,
                      "name": "namespace",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_info, namespace)",
                      "refresh": 1,
                      "regex": "",
                      "sort": 2,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Compute Resources / Namespace",
          "uid": "85a562078cdf77779eaa1add43ccec1e",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-k8s-resources-namespace
    namespace: monitoring
- apiVersion: v1
  data:
    k8s-resources-pod.json: |-
      {
          "annotations": {
              "list": [

              ]
          },
          "editable": true,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "links": [

          ],
          "refresh": "10s",
          "rows": [
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 1,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\", pod_name=\"$pod\", container_name!=\"POD\"}) by (container_name)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{container_name}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU Usage",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 2,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "CPU Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "CPU Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "CPU Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Container",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "container",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\", pod_name=\"$pod\", container_name!=\"POD\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_cpu_cores{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\", pod_name=\"$pod\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container) / sum(kube_pod_container_resource_requests_cpu_cores{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_cpu_cores{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(namespace_pod_name_container_name:container_cpu_usage_seconds_total:sum_rate{namespace=\"$namespace\", pod_name=\"$pod\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container) / sum(kube_pod_container_resource_limits_cpu_cores{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Quota",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "CPU Quota",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 10,
                          "id": 3,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 0,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": true,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum(container_memory_usage_bytes{namespace=\"$namespace\", pod_name=\"$pod\", container_name!=\"POD\", container_name!=\"\"}) by (container_name)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{container_name}}",
                                  "legendLink": null,
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory Usage",
                  "titleSize": "h6"
              },
              {
                  "collapse": false,
                  "height": "250px",
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "id": 4,
                          "legend": {
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null as zero",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "styles": [
                              {
                                  "alias": "Time",
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "pattern": "Time",
                                  "type": "hidden"
                              },
                              {
                                  "alias": "Memory Usage",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #A",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #B",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Requests %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #C",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Memory Limits",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #D",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "decbytes"
                              },
                              {
                                  "alias": "Memory Limits %",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "Value #E",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "percentunit"
                              },
                              {
                                  "alias": "Container",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "link": false,
                                  "linkTooltip": "Drill down",
                                  "linkUrl": "",
                                  "pattern": "container",
                                  "thresholds": [

                                  ],
                                  "type": "number",
                                  "unit": "short"
                              },
                              {
                                  "alias": "",
                                  "colorMode": null,
                                  "colors": [

                                  ],
                                  "dateFormat": "YYYY-MM-DD HH:mm:ss",
                                  "decimals": 2,
                                  "pattern": "/.*/",
                                  "thresholds": [

                                  ],
                                  "type": "string",
                                  "unit": "short"
                              }
                          ],
                          "targets": [
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\", pod_name=\"$pod\", container_name!=\"POD\", container_name!=\"\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_requests_memory_bytes{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "B",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\", pod_name=\"$pod\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container) / sum(kube_pod_container_resource_requests_memory_bytes{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "C",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(kube_pod_container_resource_limits_memory_bytes{namespace=\"$namespace\", pod=\"$pod\", container!=\"\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "D",
                                  "step": 10
                              },
                              {
                                  "expr": "sum(label_replace(container_memory_usage_bytes{namespace=\"$namespace\", pod_name=\"$pod\", container_name!=\"\"}, \"container\", \"$1\", \"container_name\", \"(.*)\")) by (container) / sum(kube_pod_container_resource_limits_memory_bytes{namespace=\"$namespace\", pod=\"$pod\"}) by (container)",
                                  "format": "table",
                                  "instant": true,
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "E",
                                  "step": 10
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Quota",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "transform": "table",
                          "type": "table",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": false
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": true,
                  "title": "Memory Quota",
                  "titleSize": "h6"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {
                          "text": "prod",
                          "value": "prod"
                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "namespace",
                      "multi": false,
                      "name": "namespace",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_info, namespace)",
                      "refresh": 1,
                      "regex": "",
                      "sort": 2,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  },
                  {
                      "allValue": null,
                      "current": {
                          "text": "prod",
                          "value": "prod"
                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "pod",
                      "multi": false,
                      "name": "pod",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_info{namespace=\"$namespace\"}, pod)",
                      "refresh": 1,
                      "regex": "",
                      "sort": 2,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Compute Resources / Pod",
          "uid": "6581e46e4e5c7ba40a07646395ef7b23",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-k8s-resources-pod
    namespace: monitoring
- apiVersion: v1
  data:
    nodes.json: |-
      {
          "__inputs": [

          ],
          "__requires": [

          ],
          "annotations": {
              "list": [

              ]
          },
          "editable": false,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "id": null,
          "links": [

          ],
          "refresh": "",
          "rows": [
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 2,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(node_load1{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "load 1m",
                                  "refId": "A"
                              },
                              {
                                  "expr": "max(node_load5{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "load 5m",
                                  "refId": "B"
                              },
                              {
                                  "expr": "max(node_load15{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "load 15m",
                                  "refId": "C"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "System load",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 3,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum by (cpu) (irate(node_cpu_seconds_total{job=\"node-exporter\", mode!=\"idle\", instance=\"$instance\"}[5m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{cpu}}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Usage Per Core",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 4,
                          "legend": {
                              "alignAsTable": "true",
                              "avg": "true",
                              "current": "true",
                              "max": "false",
                              "min": "false",
                              "rightSide": "true",
                              "show": "true",
                              "total": "false",
                              "values": "true"
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 9,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max (sum by (cpu) (irate(node_cpu_seconds_total{job=\"node-exporter\", mode!=\"idle\", instance=\"$instance\"}[2m])) ) * 100\n",
                                  "format": "time_series",
                                  "intervalFactor": 10,
                                  "legendFormat": "{{ cpu }}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Utilizaion",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "rgba(50, 172, 45, 0.97)",
                              "rgba(237, 129, 40, 0.89)",
                              "rgba(245, 54, 54, 0.9)"
                          ],
                          "datasource": "$datasource",
                          "format": "percent",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": true,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 5,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "avg(sum by (cpu) (irate(node_cpu_seconds_total{job=\"node-exporter\", mode!=\"idle\", instance=\"$instance\"}[2m]))) * 100\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "80, 90",
                          "title": "CPU Usage",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "N/A",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 6,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 9,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(\n  node_memory_MemTotal_bytes{job=\"node-exporter\", instance=\"$instance\"}\n  - node_memory_MemFree_bytes{job=\"node-exporter\", instance=\"$instance\"}\n  - node_memory_Buffers_bytes{job=\"node-exporter\", instance=\"$instance\"}\n  - node_memory_Cached_bytes{job=\"node-exporter\", instance=\"$instance\"}\n)\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "memory used",
                                  "refId": "A"
                              },
                              {
                                  "expr": "max(node_memory_Buffers_bytes{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "memory buffers",
                                  "refId": "B"
                              },
                              {
                                  "expr": "max(node_memory_Cached_bytes{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "memory cached",
                                  "refId": "C"
                              },
                              {
                                  "expr": "max(node_memory_MemFree_bytes{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "memory free",
                                  "refId": "D"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "rgba(50, 172, 45, 0.97)",
                              "rgba(237, 129, 40, 0.89)",
                              "rgba(245, 54, 54, 0.9)"
                          ],
                          "datasource": "$datasource",
                          "format": "percent",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": true,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 7,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "max(\n  (\n    (\n      node_memory_MemTotal_bytes{job=\"node-exporter\", instance=\"$instance\"}\n    - node_memory_MemFree_bytes{job=\"node-exporter\", instance=\"$instance\"}\n    - node_memory_Buffers_bytes{job=\"node-exporter\", instance=\"$instance\"}\n    - node_memory_Cached_bytes{job=\"node-exporter\", instance=\"$instance\"}\n    )\n    / node_memory_MemTotal_bytes{job=\"node-exporter\", instance=\"$instance\"}\n  ) * 100)\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "80, 90",
                          "title": "Memory Usage",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "N/A",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 8,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [
                              {
                                  "alias": "read",
                                  "yaxis": 1
                              },
                              {
                                  "alias": "io time",
                                  "yaxis": 2
                              }
                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(rate(node_disk_read_bytes_total{job=\"node-exporter\", instance=\"$instance\"}[2m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "read",
                                  "refId": "A"
                              },
                              {
                                  "expr": "max(rate(node_disk_written_bytes_total{job=\"node-exporter\", instance=\"$instance\"}[2m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "written",
                                  "refId": "B"
                              },
                              {
                                  "expr": "max(rate(node_disk_io_time_seconds_total{job=\"node-exporter\",  instance=\"$instance\"}[2m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "io time",
                                  "refId": "C"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk I/O",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "ms",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 9,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "node:node_filesystem_usage:\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{device}}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Disk Space Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "percentunit",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 10,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(rate(node_network_receive_bytes_total{job=\"node-exporter\", instance=\"$instance\", device!\u007e\"lo\"}[5m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{device}}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Network Received",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 11,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 6,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(rate(node_network_transmit_bytes_total{job=\"node-exporter\", instance=\"$instance\", device!\u007e\"lo\"}[5m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{device}}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Network Transmitted",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 12,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 9,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(\n  node_filesystem_files{job=\"node-exporter\", instance=\"$instance\"}\n  - node_filesystem_files_free{job=\"node-exporter\", instance=\"$instance\"}\n)\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "inodes used",
                                  "refId": "A"
                              },
                              {
                                  "expr": "max(node_filesystem_files_free{job=\"node-exporter\", instance=\"$instance\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "inodes free",
                                  "refId": "B"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Inodes Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "rgba(50, 172, 45, 0.97)",
                              "rgba(237, 129, 40, 0.89)",
                              "rgba(245, 54, 54, 0.9)"
                          ],
                          "datasource": "$datasource",
                          "format": "percent",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": true,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 13,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "max(\n  (\n    (\n      node_filesystem_files{job=\"node-exporter\", instance=\"$instance\"}\n    - node_filesystem_files_free{job=\"node-exporter\", instance=\"$instance\"}\n    )\n    / node_filesystem_files{job=\"node-exporter\", instance=\"$instance\"}\n  ) * 100)\n",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "80, 90",
                          "title": "Inodes Usage",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "N/A",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": null,
                      "multi": false,
                      "name": "instance",
                      "options": [

                      ],
                      "query": "label_values(node_boot_time_seconds{job=\"node-exporter\"}, instance)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Nodes",
          "uid": "fa49a4706d07a042595b664c87fb33ea",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-nodes
    namespace: monitoring
- apiVersion: v1
  data:
    persistentvolumesusage.json: |-
      {
          "__inputs": [

          ],
          "__requires": [

          ],
          "annotations": {
              "list": [

              ]
          },
          "editable": false,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "id": null,
          "links": [

          ],
          "refresh": "",
          "rows": [
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 2,
                          "legend": {
                              "alignAsTable": false,
                              "avg": true,
                              "current": true,
                              "max": true,
                              "min": true,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": true
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "(kubelet_volume_stats_capacity_bytes{job=\"kubelet\", persistentvolumeclaim=\"$volume\"} - kubelet_volume_stats_available_bytes{job=\"kubelet\", persistentvolumeclaim=\"$volume\"}) / kubelet_volume_stats_capacity_bytes{job=\"kubelet\", persistentvolumeclaim=\"$volume\"} * 100\n",
                                  "format": "time_series",
                                  "intervalFactor": 1,
                                  "legendFormat": "{{ Usage }}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Volume Space Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 3,
                          "legend": {
                              "alignAsTable": false,
                              "avg": true,
                              "current": true,
                              "max": true,
                              "min": true,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": true
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "span": 12,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "kubelet_volume_stats_inodes_used{job=\"kubelet\", persistentvolumeclaim=\"$volume\"} / kubelet_volume_stats_inodes{job=\"kubelet\", persistentvolumeclaim=\"$volume\"} * 100\n",
                                  "format": "time_series",
                                  "intervalFactor": 1,
                                  "legendFormat": "{{ Usage }}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Volume inodes Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "percent",
                                  "label": null,
                                  "logBase": 1,
                                  "max": 100,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "Namespace",
                      "multi": false,
                      "name": "namespace",
                      "options": [

                      ],
                      "query": "label_values(kubelet_volume_stats_capacity_bytes{job=\"kubelet\"}, exported_namespace)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "PersistentVolumeClaim",
                      "multi": false,
                      "name": "volume",
                      "options": [

                      ],
                      "query": "label_values(kubelet_volume_stats_capacity_bytes{job=\"kubelet\", exported_namespace=\"$namespace\"}, persistentvolumeclaim)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-7d",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Persistent Volumes",
          "uid": "919b92a8e8041bd567af9edab12c840c",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-persistentvolumesusage
    namespace: monitoring
- apiVersion: v1
  data:
    pods.json: |-
      {
          "__inputs": [

          ],
          "__requires": [

          ],
          "annotations": {
              "list": [

              ]
          },
          "editable": false,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "id": null,
          "links": [

          ],
          "refresh": "",
          "rows": [
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 2,
                          "legend": {
                              "alignAsTable": true,
                              "avg": true,
                              "current": true,
                              "max": false,
                              "min": false,
                              "rightSide": true,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum by(container_name) (container_memory_usage_bytes{job=\"kubelet\", namespace=\"$namespace\", pod_name=\"$pod\", container_name=\u007e\"$container\", container_name!=\"POD\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Current: {{ container_name }}",
                                  "refId": "A"
                              },
                              {
                                  "expr": "sum by(container) (kube_pod_container_resource_requests_memory_bytes{job=\"kube-state-metrics\", namespace=\"$namespace\", pod=\"$pod\", container=\u007e\"$container\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Requested: {{ container }}",
                                  "refId": "B"
                              },
                              {
                                  "expr": "sum by(container) (kube_pod_container_resource_limits_memory_bytes{job=\"kube-state-metrics\", namespace=\"$namespace\", pod=\"$pod\", container=\u007e\"$container\"})",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "Limit: {{ container }}",
                                  "refId": "C"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Memory Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 3,
                          "legend": {
                              "alignAsTable": true,
                              "avg": true,
                              "current": true,
                              "max": false,
                              "min": false,
                              "rightSide": true,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sum by (container_name) (rate(container_cpu_usage_seconds_total{job=\"kubelet\", namespace=\"$namespace\", image!=\"\",container_name!=\"POD\",pod_name=\"$pod\"}[1m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{ container_name }}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "CPU Usage",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 4,
                          "legend": {
                              "alignAsTable": true,
                              "avg": true,
                              "current": true,
                              "max": false,
                              "min": false,
                              "rightSide": true,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "sort_desc(sum by (pod_name) (rate(container_network_receive_bytes_total{job=\"kubelet\", namespace=\"$namespace\", pod_name=\"$pod\"}[1m])))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "{{ pod_name }}",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Network I/O",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              },
                              {
                                  "format": "bytes",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": 0,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "Namespace",
                      "multi": false,
                      "name": "namespace",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_info, namespace)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "Pod",
                      "multi": false,
                      "name": "pod",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_info{namespace=\u007e\"$namespace\"}, pod)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": true,
                      "label": "Container",
                      "multi": false,
                      "name": "container",
                      "options": [

                      ],
                      "query": "label_values(kube_pod_container_info{namespace=\"$namespace\", pod=\"$pod\"}, container)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / Pods",
          "uid": "ab4f13a9892a76a4d21ce8c2445bf4ea",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-pods
    namespace: monitoring
- apiVersion: v1
  data:
    statefulset.json: |-
      {
          "__inputs": [

          ],
          "__requires": [

          ],
          "annotations": {
              "list": [

              ]
          },
          "editable": false,
          "gnetId": null,
          "graphTooltip": 0,
          "hideControls": false,
          "id": null,
          "links": [

          ],
          "refresh": "",
          "rows": [
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 2,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "cores",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 4,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "lineColor": "rgb(31, 120, 193)",
                              "show": true
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "sum(rate(container_cpu_usage_seconds_total{job=\"kubelet\", namespace=\"$namespace\", pod_name=\u007e\"$statefulset.*\"}[3m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "CPU",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 3,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "GB",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 4,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "lineColor": "rgb(31, 120, 193)",
                              "show": true
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "sum(container_memory_usage_bytes{job=\"kubelet\", namespace=\"$namespace\", pod_name=\u007e\"$statefulset.*\"}) / 1024^3",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Memory",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 4,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "Bps",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 4,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "lineColor": "rgb(31, 120, 193)",
                              "show": true
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "sum(rate(container_network_transmit_bytes_total{job=\"kubelet\", namespace=\"$namespace\", pod_name=\u007e\"$statefulset.*\"}[3m])) + sum(rate(container_network_receive_bytes_total{namespace=\"$namespace\",pod_name=\u007e\"$statefulset.*\"}[3m]))",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Network",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "height": "100px",
                  "panels": [
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 5,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "max(kube_statefulset_replicas{job=\"kube-state-metrics\", namespace=\"$namespace\", statefulset=\"$statefulset\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Desired Replicas",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 6,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "min(kube_statefulset_status_replicas_current{job=\"kube-state-metrics\", namespace=\"$namespace\", statefulset=\"$statefulset\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Replicas of current version",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 7,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "max(kube_statefulset_status_observed_generation{job=\"kube-state-metrics\",  namespace=\"$namespace\", statefulset=\"$statefulset\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Observed Generation",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      },
                      {
                          "cacheTimeout": null,
                          "colorBackground": false,
                          "colorValue": false,
                          "colors": [
                              "#299c46",
                              "rgba(237, 129, 40, 0.89)",
                              "#d44a3a"
                          ],
                          "datasource": "$datasource",
                          "format": "none",
                          "gauge": {
                              "maxValue": 100,
                              "minValue": 0,
                              "show": false,
                              "thresholdLabels": false,
                              "thresholdMarkers": true
                          },
                          "gridPos": {

                          },
                          "id": 8,
                          "interval": null,
                          "links": [

                          ],
                          "mappingType": 1,
                          "mappingTypes": [
                              {
                                  "name": "value to text",
                                  "value": 1
                              },
                              {
                                  "name": "range to text",
                                  "value": 2
                              }
                          ],
                          "maxDataPoints": 100,
                          "nullPointMode": "connected",
                          "nullText": null,
                          "postfix": "",
                          "postfixFontSize": "50%",
                          "prefix": "",
                          "prefixFontSize": "50%",
                          "rangeMaps": [
                              {
                                  "from": "null",
                                  "text": "N/A",
                                  "to": "null"
                              }
                          ],
                          "span": 3,
                          "sparkline": {
                              "fillColor": "rgba(31, 118, 189, 0.18)",
                              "full": false,
                              "lineColor": "rgb(31, 120, 193)",
                              "show": false
                          },
                          "tableColumn": "",
                          "targets": [
                              {
                                  "expr": "max(kube_statefulset_metadata_generation{job=\"kube-state-metrics\", statefulset=\"$statefulset\", namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "",
                                  "refId": "A"
                              }
                          ],
                          "thresholds": "",
                          "title": "Metadata Generation",
                          "type": "singlestat",
                          "valueFontSize": "80%",
                          "valueMaps": [
                              {
                                  "op": "=",
                                  "text": "0",
                                  "value": "null"
                              }
                          ],
                          "valueName": "current"
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              },
              {
                  "collapse": false,
                  "collapsed": false,
                  "panels": [
                      {
                          "aliasColors": {

                          },
                          "bars": false,
                          "dashLength": 10,
                          "dashes": false,
                          "datasource": "$datasource",
                          "fill": 1,
                          "gridPos": {

                          },
                          "id": 9,
                          "legend": {
                              "alignAsTable": false,
                              "avg": false,
                              "current": false,
                              "max": false,
                              "min": false,
                              "rightSide": false,
                              "show": true,
                              "total": false,
                              "values": false
                          },
                          "lines": true,
                          "linewidth": 1,
                          "links": [

                          ],
                          "nullPointMode": "null",
                          "percentage": false,
                          "pointradius": 5,
                          "points": false,
                          "renderer": "flot",
                          "repeat": null,
                          "seriesOverrides": [

                          ],
                          "spaceLength": 10,
                          "stack": false,
                          "steppedLine": false,
                          "targets": [
                              {
                                  "expr": "max(kube_statefulset_replicas{job=\"kube-state-metrics\", statefulset=\"$statefulset\",namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "replicas specified",
                                  "refId": "A"
                              },
                              {
                                  "expr": "max(kube_statefulset_status_replicas{job=\"kube-state-metrics\", statefulset=\"$statefulset\",namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "replicas created",
                                  "refId": "B"
                              },
                              {
                                  "expr": "min(kube_statefulset_status_replicas_ready{job=\"kube-state-metrics\", statefulset=\"$statefulset\",namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "ready",
                                  "refId": "C"
                              },
                              {
                                  "expr": "min(kube_statefulset_status_replicas_current{job=\"kube-state-metrics\", statefulset=\"$statefulset\",namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "replicas of current version",
                                  "refId": "D"
                              },
                              {
                                  "expr": "min(kube_statefulset_status_replicas_updated{job=\"kube-state-metrics\", statefulset=\"$statefulset\",namespace=\"$namespace\"}) without (instance, pod)",
                                  "format": "time_series",
                                  "intervalFactor": 2,
                                  "legendFormat": "updated",
                                  "refId": "E"
                              }
                          ],
                          "thresholds": [

                          ],
                          "timeFrom": null,
                          "timeShift": null,
                          "title": "Replicas",
                          "tooltip": {
                              "shared": true,
                              "sort": 0,
                              "value_type": "individual"
                          },
                          "type": "graph",
                          "xaxis": {
                              "buckets": null,
                              "mode": "time",
                              "name": null,
                              "show": true,
                              "values": [

                              ]
                          },
                          "yaxes": [
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              },
                              {
                                  "format": "short",
                                  "label": null,
                                  "logBase": 1,
                                  "max": null,
                                  "min": null,
                                  "show": true
                              }
                          ]
                      }
                  ],
                  "repeat": null,
                  "repeatIteration": null,
                  "repeatRowId": null,
                  "showTitle": false,
                  "title": "Dashboard Row",
                  "titleSize": "h6",
                  "type": "row"
              }
          ],
          "schemaVersion": 14,
          "style": "dark",
          "tags": [
              "kubernetes-mixin"
          ],
          "templating": {
              "list": [
                  {
                      "current": {
                          "text": "Prometheus",
                          "value": "Prometheus"
                      },
                      "hide": 0,
                      "label": null,
                      "name": "datasource",
                      "options": [

                      ],
                      "query": "prometheus",
                      "refresh": 1,
                      "regex": "",
                      "type": "datasource"
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "Namespace",
                      "multi": false,
                      "name": "namespace",
                      "options": [

                      ],
                      "query": "label_values(kube_statefulset_metadata_generation{job=\"kube-state-metrics\"}, namespace)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  },
                  {
                      "allValue": null,
                      "current": {

                      },
                      "datasource": "$datasource",
                      "hide": 0,
                      "includeAll": false,
                      "label": "Name",
                      "multi": false,
                      "name": "statefulset",
                      "options": [

                      ],
                      "query": "label_values(kube_statefulset_metadata_generation{job=\"kube-state-metrics\", namespace=\"$namespace\"}, statefulset)",
                      "refresh": 2,
                      "regex": "",
                      "sort": 0,
                      "tagValuesQuery": "",
                      "tags": [

                      ],
                      "tagsQuery": "",
                      "type": "query",
                      "useTags": false
                  }
              ]
          },
          "time": {
              "from": "now-1h",
              "to": "now"
          },
          "timepicker": {
              "refresh_intervals": [
                  "5s",
                  "10s",
                  "30s",
                  "1m",
                  "5m",
                  "15m",
                  "30m",
                  "1h",
                  "2h",
                  "1d"
              ],
              "time_options": [
                  "5m",
                  "15m",
                  "1h",
                  "6h",
                  "12h",
                  "24h",
                  "2d",
                  "7d",
                  "30d"
              ]
          },
          "timezone": "",
          "title": "Kubernetes / StatefulSets",
          "uid": "a31c1f46e6f727cb37c0d731a7245005",
          "version": 0
      }
  kind: ConfigMap
  metadata:
    name: grafana-dashboard-statefulset
    namespace: monitoring
kind: ConfigMapList
{%- endraw %}
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: grafana
  namespace: monitoring
spec:
  endpoints:
  - interval: 15s
    port: http
  selector:
    matchLabels:
      app: grafana
---
apiVersion: v1
data:
  prometheus.yaml: |-
    {
        "apiVersion": 1,
        "datasources": [
            {
                "access": "proxy",
                "editable": false,
                "name": "prometheus",
                "orgId": 1,
                "type": "prometheus",
                "url": "http://prometheus-k8s.monitoring.svc:9090",
                "version": 1
            }
        ]
    }
kind: ConfigMap
metadata:
  name: grafana-datasources
  namespace: monitoring
type: Opaque
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: grafana
  name: grafana
  namespace: monitoring
spec:
  ports:
  - name: http
    port: 3000
    targetPort: http
  selector:
    app: grafana
---
apiVersion: v1
data:
  dashboards.yaml: |-
    {
        "apiVersion": 1,
        "providers": [
            {
                "folder": "",
                "name": "0",
                "options": {
                    "path": "/grafana-dashboard-definitions/0"
                },
                "orgId": 1,
                "type": "file"
            }
        ]
    }
kind: ConfigMap
metadata:
  name: grafana-dashboards
  namespace: monitoring
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: grafana
  namespace: monitoring
