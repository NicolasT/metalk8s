#!jinja | kubernetes kubeconfig=/etc/kubernetes/admin.conf&context=kubernetes-admin@kubernetes

{%- from "metalk8s/repo/macro.sls" import build_image_name with context %}

# The content below has been generated from
# https://github.com/coreos/prometheus-operator, v0.29.0 tag,
# with the following command:
#   hack/concat-kubernetes-manifests.sh $(find contrib/kube-prometheus/manifests/ \
#     -name "0*.yaml" | sort) > deployed.sls
# In the following, only container image registries have been replaced.

---
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  creationTimestamp: null
  name: alertmanagers.monitoring.coreos.com
spec:
  group: monitoring.coreos.com
  names:
    kind: Alertmanager
    plural: alertmanagers
  scope: Namespaced
  validation:
    openAPIV3Schema:
      properties:
        apiVersion:
          description: 'APIVersion defines the versioned schema of this representation
            of an object. Servers should convert recognized schemas to the latest
            internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
          type: string
        kind:
          description: 'Kind is a string value representing the REST resource this
            object represents. Servers may infer this from the endpoint the client
            submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
          type: string
        spec:
          description: 'AlertmanagerSpec is a specification of the desired behavior
            of the Alertmanager cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md#spec-and-status'
          properties:
            additionalPeers:
              description: AdditionalPeers allows injecting a set of additional Alertmanagers
                to peer with to form a highly available cluster.
              items:
                type: string
              type: array
            affinity:
              description: Affinity is a group of affinity scheduling rules.
              properties:
                nodeAffinity:
                  description: Node affinity is a group of node affinity scheduling
                    rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the affinity expressions specified by this field,
                        but it may choose a node that violates one or more of the
                        expressions. The node that is most preferred is the one with
                        the greatest sum of weights, i.e. for each node that meets
                        all of the scheduling requirements (resource request, requiredDuringScheduling
                        affinity expressions, etc.), compute a sum by iterating through
                        the elements of this field and adding "weight" to the sum
                        if the node matches the corresponding matchExpressions; the
                        node(s) with the highest sum are the most preferred.
                      items:
                        description: An empty preferred scheduling term matches all
                          objects with implicit weight 0 (i.e. it's a no-op). A null
                          preferred scheduling term matches no objects (i.e. is also
                          a no-op).
                        properties:
                          preference:
                            description: A null or empty node selector term matches
                              no objects. The requirements of them are ANDed. The
                              TopologySelectorTerm type implements a subset of the
                              NodeSelectorTerm.
                            properties:
                              matchExpressions:
                                description: A list of node selector requirements
                                  by node's labels.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchFields:
                                description: A list of node selector requirements
                                  by node's fields.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                          weight:
                            description: Weight associated with matching the corresponding
                              nodeSelectorTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - preference
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: A node selector represents the union of the results
                        of one or more label queries over a set of nodes; that is,
                        it represents the OR of the selectors represented by the node
                        selector terms.
                      properties:
                        nodeSelectorTerms:
                          description: Required. A list of node selector terms. The
                            terms are ORed.
                          items:
                            description: A null or empty node selector term matches
                              no objects. The requirements of them are ANDed. The
                              TopologySelectorTerm type implements a subset of the
                              NodeSelectorTerm.
                            properties:
                              matchExpressions:
                                description: A list of node selector requirements
                                  by node's labels.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchFields:
                                description: A list of node selector requirements
                                  by node's fields.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                          type: array
                      required:
                      - nodeSelectorTerms
                podAffinity:
                  description: Pod affinity is a group of inter pod affinity scheduling
                    rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the affinity expressions specified by this field,
                        but it may choose a node that violates one or more of the
                        expressions. The node that is most preferred is the one with
                        the greatest sum of weights, i.e. for each node that meets
                        all of the scheduling requirements (resource request, requiredDuringScheduling
                        affinity expressions, etc.), compute a sum by iterating through
                        the elements of this field and adding "weight" to the sum
                        if the node has pods which matches the corresponding podAffinityTerm;
                        the node(s) with the highest sum are the most preferred.
                      items:
                        description: The weights of all of the matched WeightedPodAffinityTerm
                          fields are added per-node to find the most preferred node(s)
                        properties:
                          podAffinityTerm:
                            description: Defines a set of pods (namely those matching
                              the labelSelector relative to the given namespace(s))
                              that this pod should be co-located (affinity) or not
                              co-located (anti-affinity) with, where co-located is
                              defined as running on a node whose value of the label
                              with key <topologyKey> matches that of any node on which
                              a pod of the set of pods is running
                            properties:
                              labelSelector:
                                description: A label selector is a label query over
                                  a set of resources. The result of matchLabels and
                                  matchExpressions are ANDed. An empty label selector
                                  matches all objects. A null label selector matches
                                  no objects.
                                properties:
                                  matchExpressions:
                                    description: matchExpressions is a list of label
                                      selector requirements. The requirements are
                                      ANDed.
                                    items:
                                      description: A label selector requirement is
                                        a selector that contains values, a key, and
                                        an operator that relates the key and values.
                                      properties:
                                        key:
                                          description: key is the label key that the
                                            selector applies to.
                                          type: string
                                        operator:
                                          description: operator represents a key's
                                            relationship to a set of values. Valid
                                            operators are In, NotIn, Exists and DoesNotExist.
                                          type: string
                                        values:
                                          description: values is an array of string
                                            values. If the operator is In or NotIn,
                                            the values array must be non-empty. If
                                            the operator is Exists or DoesNotExist,
                                            the values array must be empty. This array
                                            is replaced during a strategic merge patch.
                                          items:
                                            type: string
                                          type: array
                                      required:
                                      - key
                                      - operator
                                    type: array
                                  matchLabels:
                                    description: matchLabels is a map of {key,value}
                                      pairs. A single {key,value} in the matchLabels
                                      map is equivalent to an element of matchExpressions,
                                      whose key field is "key", the operator is "In",
                                      and the values array contains only "value".
                                      The requirements are ANDed.
                                    type: object
                              namespaces:
                                description: namespaces specifies which namespaces
                                  the labelSelector applies to (matches against);
                                  null or empty list means "this pod's namespace"
                                items:
                                  type: string
                                type: array
                              topologyKey:
                                description: This pod should be co-located (affinity)
                                  or not co-located (anti-affinity) with the pods
                                  matching the labelSelector in the specified namespaces,
                                  where co-located is defined as running on a node
                                  whose value of the label with key topologyKey matches
                                  that of any node on which any of the selected pods
                                  is running. Empty topologyKey is not allowed.
                                type: string
                            required:
                            - topologyKey
                          weight:
                            description: weight associated with matching the corresponding
                              podAffinityTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - podAffinityTerm
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: If the affinity requirements specified by this
                        field are not met at scheduling time, the pod will not be
                        scheduled onto the node. If the affinity requirements specified
                        by this field cease to be met at some point during pod execution
                        (e.g. due to a pod label update), the system may or may not
                        try to eventually evict the pod from its node. When there
                        are multiple elements, the lists of nodes corresponding to
                        each podAffinityTerm are intersected, i.e. all terms must
                        be satisfied.
                      items:
                        description: Defines a set of pods (namely those matching
                          the labelSelector relative to the given namespace(s)) that
                          this pod should be co-located (affinity) or not co-located
                          (anti-affinity) with, where co-located is defined as running
                          on a node whose value of the label with key <topologyKey>
                          matches that of any node on which a pod of the set of pods
                          is running
                        properties:
                          labelSelector:
                            description: A label selector is a label query over a
                              set of resources. The result of matchLabels and matchExpressions
                              are ANDed. An empty label selector matches all objects.
                              A null label selector matches no objects.
                            properties:
                              matchExpressions:
                                description: matchExpressions is a list of label selector
                                  requirements. The requirements are ANDed.
                                items:
                                  description: A label selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: key is the label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: operator represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists and DoesNotExist.
                                      type: string
                                    values:
                                      description: values is an array of string values.
                                        If the operator is In or NotIn, the values
                                        array must be non-empty. If the operator is
                                        Exists or DoesNotExist, the values array must
                                        be empty. This array is replaced during a
                                        strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchLabels:
                                description: matchLabels is a map of {key,value} pairs.
                                  A single {key,value} in the matchLabels map is equivalent
                                  to an element of matchExpressions, whose key field
                                  is "key", the operator is "In", and the values array
                                  contains only "value". The requirements are ANDed.
                                type: object
                          namespaces:
                            description: namespaces specifies which namespaces the
                              labelSelector applies to (matches against); null or
                              empty list means "this pod's namespace"
                            items:
                              type: string
                            type: array
                          topologyKey:
                            description: This pod should be co-located (affinity)
                              or not co-located (anti-affinity) with the pods matching
                              the labelSelector in the specified namespaces, where
                              co-located is defined as running on a node whose value
                              of the label with key topologyKey matches that of any
                              node on which any of the selected pods is running. Empty
                              topologyKey is not allowed.
                            type: string
                        required:
                        - topologyKey
                      type: array
                podAntiAffinity:
                  description: Pod anti affinity is a group of inter pod anti affinity
                    scheduling rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the anti-affinity expressions specified by this
                        field, but it may choose a node that violates one or more
                        of the expressions. The node that is most preferred is the
                        one with the greatest sum of weights, i.e. for each node that
                        meets all of the scheduling requirements (resource request,
                        requiredDuringScheduling anti-affinity expressions, etc.),
                        compute a sum by iterating through the elements of this field
                        and adding "weight" to the sum if the node has pods which
                        matches the corresponding podAffinityTerm; the node(s) with
                        the highest sum are the most preferred.
                      items:
                        description: The weights of all of the matched WeightedPodAffinityTerm
                          fields are added per-node to find the most preferred node(s)
                        properties:
                          podAffinityTerm:
                            description: Defines a set of pods (namely those matching
                              the labelSelector relative to the given namespace(s))
                              that this pod should be co-located (affinity) or not
                              co-located (anti-affinity) with, where co-located is
                              defined as running on a node whose value of the label
                              with key <topologyKey> matches that of any node on which
                              a pod of the set of pods is running
                            properties:
                              labelSelector:
                                description: A label selector is a label query over
                                  a set of resources. The result of matchLabels and
                                  matchExpressions are ANDed. An empty label selector
                                  matches all objects. A null label selector matches
                                  no objects.
                                properties:
                                  matchExpressions:
                                    description: matchExpressions is a list of label
                                      selector requirements. The requirements are
                                      ANDed.
                                    items:
                                      description: A label selector requirement is
                                        a selector that contains values, a key, and
                                        an operator that relates the key and values.
                                      properties:
                                        key:
                                          description: key is the label key that the
                                            selector applies to.
                                          type: string
                                        operator:
                                          description: operator represents a key's
                                            relationship to a set of values. Valid
                                            operators are In, NotIn, Exists and DoesNotExist.
                                          type: string
                                        values:
                                          description: values is an array of string
                                            values. If the operator is In or NotIn,
                                            the values array must be non-empty. If
                                            the operator is Exists or DoesNotExist,
                                            the values array must be empty. This array
                                            is replaced during a strategic merge patch.
                                          items:
                                            type: string
                                          type: array
                                      required:
                                      - key
                                      - operator
                                    type: array
                                  matchLabels:
                                    description: matchLabels is a map of {key,value}
                                      pairs. A single {key,value} in the matchLabels
                                      map is equivalent to an element of matchExpressions,
                                      whose key field is "key", the operator is "In",
                                      and the values array contains only "value".
                                      The requirements are ANDed.
                                    type: object
                              namespaces:
                                description: namespaces specifies which namespaces
                                  the labelSelector applies to (matches against);
                                  null or empty list means "this pod's namespace"
                                items:
                                  type: string
                                type: array
                              topologyKey:
                                description: This pod should be co-located (affinity)
                                  or not co-located (anti-affinity) with the pods
                                  matching the labelSelector in the specified namespaces,
                                  where co-located is defined as running on a node
                                  whose value of the label with key topologyKey matches
                                  that of any node on which any of the selected pods
                                  is running. Empty topologyKey is not allowed.
                                type: string
                            required:
                            - topologyKey
                          weight:
                            description: weight associated with matching the corresponding
                              podAffinityTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - podAffinityTerm
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: If the anti-affinity requirements specified by
                        this field are not met at scheduling time, the pod will not
                        be scheduled onto the node. If the anti-affinity requirements
                        specified by this field cease to be met at some point during
                        pod execution (e.g. due to a pod label update), the system
                        may or may not try to eventually evict the pod from its node.
                        When there are multiple elements, the lists of nodes corresponding
                        to each podAffinityTerm are intersected, i.e. all terms must
                        be satisfied.
                      items:
                        description: Defines a set of pods (namely those matching
                          the labelSelector relative to the given namespace(s)) that
                          this pod should be co-located (affinity) or not co-located
                          (anti-affinity) with, where co-located is defined as running
                          on a node whose value of the label with key <topologyKey>
                          matches that of any node on which a pod of the set of pods
                          is running
                        properties:
                          labelSelector:
                            description: A label selector is a label query over a
                              set of resources. The result of matchLabels and matchExpressions
                              are ANDed. An empty label selector matches all objects.
                              A null label selector matches no objects.
                            properties:
                              matchExpressions:
                                description: matchExpressions is a list of label selector
                                  requirements. The requirements are ANDed.
                                items:
                                  description: A label selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: key is the label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: operator represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists and DoesNotExist.
                                      type: string
                                    values:
                                      description: values is an array of string values.
                                        If the operator is In or NotIn, the values
                                        array must be non-empty. If the operator is
                                        Exists or DoesNotExist, the values array must
                                        be empty. This array is replaced during a
                                        strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchLabels:
                                description: matchLabels is a map of {key,value} pairs.
                                  A single {key,value} in the matchLabels map is equivalent
                                  to an element of matchExpressions, whose key field
                                  is "key", the operator is "In", and the values array
                                  contains only "value". The requirements are ANDed.
                                type: object
                          namespaces:
                            description: namespaces specifies which namespaces the
                              labelSelector applies to (matches against); null or
                              empty list means "this pod's namespace"
                            items:
                              type: string
                            type: array
                          topologyKey:
                            description: This pod should be co-located (affinity)
                              or not co-located (anti-affinity) with the pods matching
                              the labelSelector in the specified namespaces, where
                              co-located is defined as running on a node whose value
                              of the label with key topologyKey matches that of any
                              node on which any of the selected pods is running. Empty
                              topologyKey is not allowed.
                            type: string
                        required:
                        - topologyKey
                      type: array
            baseImage:
              description: Base image that is used to deploy pods, without tag.
              type: string
            configMaps:
              description: ConfigMaps is a list of ConfigMaps in the same namespace
                as the Alertmanager object, which shall be mounted into the Alertmanager
                Pods. The ConfigMaps are mounted into /etc/alertmanager/configmaps/<configmap-name>.
              items:
                type: string
              type: array
            containers:
              description: Containers allows injecting additional containers. This
                is meant to allow adding an authentication proxy to an Alertmanager
                pod.
              items:
                description: A single application container that you want to run within
                  a pod.
                properties:
                  args:
                    description: 'Arguments to the entrypoint. The docker image''s
                      CMD is used if this is not provided. Variable references $(VAR_NAME)
                      are expanded using the container''s environment. If a variable
                      cannot be resolved, the reference in the input string will be
                      unchanged. The $(VAR_NAME) syntax can be escaped with a double
                      $$, ie: $$(VAR_NAME). Escaped references will never be expanded,
                      regardless of whether the variable exists or not. Cannot be
                      updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                    items:
                      type: string
                    type: array
                  command:
                    description: 'Entrypoint array. Not executed within a shell. The
                      docker image''s ENTRYPOINT is used if this is not provided.
                      Variable references $(VAR_NAME) are expanded using the container''s
                      environment. If a variable cannot be resolved, the reference
                      in the input string will be unchanged. The $(VAR_NAME) syntax
                      can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references
                      will never be expanded, regardless of whether the variable exists
                      or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                    items:
                      type: string
                    type: array
                  env:
                    description: List of environment variables to set in the container.
                      Cannot be updated.
                    items:
                      description: EnvVar represents an environment variable present
                        in a Container.
                      properties:
                        name:
                          description: Name of the environment variable. Must be a
                            C_IDENTIFIER.
                          type: string
                        value:
                          description: 'Variable references $(VAR_NAME) are expanded
                            using the previous defined environment variables in the
                            container and any service environment variables. If a
                            variable cannot be resolved, the reference in the input
                            string will be unchanged. The $(VAR_NAME) syntax can be
                            escaped with a double $$, ie: $$(VAR_NAME). Escaped references
                            will never be expanded, regardless of whether the variable
                            exists or not. Defaults to "".'
                          type: string
                        valueFrom:
                          description: EnvVarSource represents a source for the value
                            of an EnvVar.
                          properties:
                            configMapKeyRef:
                              description: Selects a key from a ConfigMap.
                              properties:
                                key:
                                  description: The key to select.
                                  type: string
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                                  type: string
                                optional:
                                  description: Specify whether the ConfigMap or it's
                                    key must be defined
                                  type: boolean
                              required:
                              - key
                            fieldRef:
                              description: ObjectFieldSelector selects an APIVersioned
                                field of an object.
                              properties:
                                apiVersion:
                                  description: Version of the schema the FieldPath
                                    is written in terms of, defaults to "v1".
                                  type: string
                                fieldPath:
                                  description: Path of the field to select in the
                                    specified API version.
                                  type: string
                              required:
                              - fieldPath
                            resourceFieldRef:
                              description: ResourceFieldSelector represents container
                                resources (cpu, memory) and their output format
                              properties:
                                containerName:
                                  description: 'Container name: required for volumes,
                                    optional for env vars'
                                  type: string
                                divisor: {}
                                resource:
                                  description: 'Required: resource to select'
                                  type: string
                              required:
                              - resource
                            secretKeyRef:
                              description: SecretKeySelector selects a key of a Secret.
                              properties:
                                key:
                                  description: The key of the secret to select from.  Must
                                    be a valid secret key.
                                  type: string
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                                  type: string
                                optional:
                                  description: Specify whether the Secret or it's
                                    key must be defined
                                  type: boolean
                              required:
                              - key
                      required:
                      - name
                    type: array
                  envFrom:
                    description: List of sources to populate environment variables
                      in the container. The keys defined within a source must be a
                      C_IDENTIFIER. All invalid keys will be reported as an event
                      when the container is starting. When a key exists in multiple
                      sources, the value associated with the last source will take
                      precedence. Values defined by an Env with a duplicate key will
                      take precedence. Cannot be updated.
                    items:
                      description: EnvFromSource represents the source of a set of
                        ConfigMaps
                      properties:
                        configMapRef:
                          description: |-
                            ConfigMapEnvSource selects a ConfigMap to populate the environment variables with.

                            The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            optional:
                              description: Specify whether the ConfigMap must be defined
                              type: boolean
                        prefix:
                          description: An optional identifier to prepend to each key
                            in the ConfigMap. Must be a C_IDENTIFIER.
                          type: string
                        secretRef:
                          description: |-
                            SecretEnvSource selects a Secret to populate the environment variables with.

                            The contents of the target Secret's Data field will represent the key-value pairs as environment variables.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            optional:
                              description: Specify whether the Secret must be defined
                              type: boolean
                    type: array
                  image:
                    description: 'Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images
                      This field is optional to allow higher level config management
                      to default or override container images in workload controllers
                      like Deployments and StatefulSets.'
                    type: string
                  imagePullPolicy:
                    description: 'Image pull policy. One of Always, Never, IfNotPresent.
                      Defaults to Always if :latest tag is specified, or IfNotPresent
                      otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images'
                    type: string
                  lifecycle:
                    description: Lifecycle describes actions that the management system
                      should take in response to container lifecycle events. For the
                      PostStart and PreStop lifecycle handlers, management of the
                      container blocks until the action is complete, unless the container
                      process fails, in which case the handler is aborted.
                    properties:
                      postStart:
                        description: Handler defines a specific action that should
                          be taken
                        properties:
                          exec:
                            description: ExecAction describes a "run in container"
                              action.
                            properties:
                              command:
                                description: Command is the command line to execute
                                  inside the container, the working directory for
                                  the command  is root ('/') in the container's filesystem.
                                  The command is simply exec'd, it is not run inside
                                  a shell, so traditional shell instructions ('|',
                                  etc) won't work. To use a shell, you need to explicitly
                                  call out to that shell. Exit status of 0 is treated
                                  as live/healthy and non-zero is unhealthy.
                                items:
                                  type: string
                                type: array
                          httpGet:
                            description: HTTPGetAction describes an action based on
                              HTTP Get requests.
                            properties:
                              host:
                                description: Host name to connect to, defaults to
                                  the pod IP. You probably want to set "Host" in httpHeaders
                                  instead.
                                type: string
                              httpHeaders:
                                description: Custom headers to set in the request.
                                  HTTP allows repeated headers.
                                items:
                                  description: HTTPHeader describes a custom header
                                    to be used in HTTP probes
                                  properties:
                                    name:
                                      description: The header field name
                                      type: string
                                    value:
                                      description: The header field value
                                      type: string
                                  required:
                                  - name
                                  - value
                                type: array
                              path:
                                description: Path to access on the HTTP server.
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                              scheme:
                                description: Scheme to use for connecting to the host.
                                  Defaults to HTTP.
                                type: string
                            required:
                            - port
                          tcpSocket:
                            description: TCPSocketAction describes an action based
                              on opening a socket
                            properties:
                              host:
                                description: 'Optional: Host name to connect to, defaults
                                  to the pod IP.'
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                            required:
                            - port
                      preStop:
                        description: Handler defines a specific action that should
                          be taken
                        properties:
                          exec:
                            description: ExecAction describes a "run in container"
                              action.
                            properties:
                              command:
                                description: Command is the command line to execute
                                  inside the container, the working directory for
                                  the command  is root ('/') in the container's filesystem.
                                  The command is simply exec'd, it is not run inside
                                  a shell, so traditional shell instructions ('|',
                                  etc) won't work. To use a shell, you need to explicitly
                                  call out to that shell. Exit status of 0 is treated
                                  as live/healthy and non-zero is unhealthy.
                                items:
                                  type: string
                                type: array
                          httpGet:
                            description: HTTPGetAction describes an action based on
                              HTTP Get requests.
                            properties:
                              host:
                                description: Host name to connect to, defaults to
                                  the pod IP. You probably want to set "Host" in httpHeaders
                                  instead.
                                type: string
                              httpHeaders:
                                description: Custom headers to set in the request.
                                  HTTP allows repeated headers.
                                items:
                                  description: HTTPHeader describes a custom header
                                    to be used in HTTP probes
                                  properties:
                                    name:
                                      description: The header field name
                                      type: string
                                    value:
                                      description: The header field value
                                      type: string
                                  required:
                                  - name
                                  - value
                                type: array
                              path:
                                description: Path to access on the HTTP server.
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                              scheme:
                                description: Scheme to use for connecting to the host.
                                  Defaults to HTTP.
                                type: string
                            required:
                            - port
                          tcpSocket:
                            description: TCPSocketAction describes an action based
                              on opening a socket
                            properties:
                              host:
                                description: 'Optional: Host name to connect to, defaults
                                  to the pod IP.'
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                            required:
                            - port
                  livenessProbe:
                    description: Probe describes a health check to be performed against
                      a container to determine whether it is alive or ready to receive
                      traffic.
                    properties:
                      exec:
                        description: ExecAction describes a "run in container" action.
                        properties:
                          command:
                            description: Command is the command line to execute inside
                              the container, the working directory for the command  is
                              root ('/') in the container's filesystem. The command
                              is simply exec'd, it is not run inside a shell, so traditional
                              shell instructions ('|', etc) won't work. To use a shell,
                              you need to explicitly call out to that shell. Exit
                              status of 0 is treated as live/healthy and non-zero
                              is unhealthy.
                            items:
                              type: string
                            type: array
                      failureThreshold:
                        description: Minimum consecutive failures for the probe to
                          be considered failed after having succeeded. Defaults to
                          3. Minimum value is 1.
                        format: int32
                        type: integer
                      httpGet:
                        description: HTTPGetAction describes an action based on HTTP
                          Get requests.
                        properties:
                          host:
                            description: Host name to connect to, defaults to the
                              pod IP. You probably want to set "Host" in httpHeaders
                              instead.
                            type: string
                          httpHeaders:
                            description: Custom headers to set in the request. HTTP
                              allows repeated headers.
                            items:
                              description: HTTPHeader describes a custom header to
                                be used in HTTP probes
                              properties:
                                name:
                                  description: The header field name
                                  type: string
                                value:
                                  description: The header field value
                                  type: string
                              required:
                              - name
                              - value
                            type: array
                          path:
                            description: Path to access on the HTTP server.
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                          scheme:
                            description: Scheme to use for connecting to the host.
                              Defaults to HTTP.
                            type: string
                        required:
                        - port
                      initialDelaySeconds:
                        description: 'Number of seconds after the container has started
                          before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                      periodSeconds:
                        description: How often (in seconds) to perform the probe.
                          Default to 10 seconds. Minimum value is 1.
                        format: int32
                        type: integer
                      successThreshold:
                        description: Minimum consecutive successes for the probe to
                          be considered successful after having failed. Defaults to
                          1. Must be 1 for liveness. Minimum value is 1.
                        format: int32
                        type: integer
                      tcpSocket:
                        description: TCPSocketAction describes an action based on
                          opening a socket
                        properties:
                          host:
                            description: 'Optional: Host name to connect to, defaults
                              to the pod IP.'
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                        required:
                        - port
                      timeoutSeconds:
                        description: 'Number of seconds after which the probe times
                          out. Defaults to 1 second. Minimum value is 1. More info:
                          https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                  name:
                    description: Name of the container specified as a DNS_LABEL. Each
                      container in a pod must have a unique name (DNS_LABEL). Cannot
                      be updated.
                    type: string
                  ports:
                    description: List of ports to expose from the container. Exposing
                      a port here gives the system additional information about the
                      network connections a container uses, but is primarily informational.
                      Not specifying a port here DOES NOT prevent that port from being
                      exposed. Any port which is listening on the default "0.0.0.0"
                      address inside a container will be accessible from the network.
                      Cannot be updated.
                    items:
                      description: ContainerPort represents a network port in a single
                        container.
                      properties:
                        containerPort:
                          description: Number of port to expose on the pod's IP address.
                            This must be a valid port number, 0 < x < 65536.
                          format: int32
                          type: integer
                        hostIP:
                          description: What host IP to bind the external port to.
                          type: string
                        hostPort:
                          description: Number of port to expose on the host. If specified,
                            this must be a valid port number, 0 < x < 65536. If HostNetwork
                            is specified, this must match ContainerPort. Most containers
                            do not need this.
                          format: int32
                          type: integer
                        name:
                          description: If specified, this must be an IANA_SVC_NAME
                            and unique within the pod. Each named port in a pod must
                            have a unique name. Name for the port that can be referred
                            to by services.
                          type: string
                        protocol:
                          description: Protocol for port. Must be UDP, TCP, or SCTP.
                            Defaults to "TCP".
                          type: string
                      required:
                      - containerPort
                    type: array
                  readinessProbe:
                    description: Probe describes a health check to be performed against
                      a container to determine whether it is alive or ready to receive
                      traffic.
                    properties:
                      exec:
                        description: ExecAction describes a "run in container" action.
                        properties:
                          command:
                            description: Command is the command line to execute inside
                              the container, the working directory for the command  is
                              root ('/') in the container's filesystem. The command
                              is simply exec'd, it is not run inside a shell, so traditional
                              shell instructions ('|', etc) won't work. To use a shell,
                              you need to explicitly call out to that shell. Exit
                              status of 0 is treated as live/healthy and non-zero
                              is unhealthy.
                            items:
                              type: string
                            type: array
                      failureThreshold:
                        description: Minimum consecutive failures for the probe to
                          be considered failed after having succeeded. Defaults to
                          3. Minimum value is 1.
                        format: int32
                        type: integer
                      httpGet:
                        description: HTTPGetAction describes an action based on HTTP
                          Get requests.
                        properties:
                          host:
                            description: Host name to connect to, defaults to the
                              pod IP. You probably want to set "Host" in httpHeaders
                              instead.
                            type: string
                          httpHeaders:
                            description: Custom headers to set in the request. HTTP
                              allows repeated headers.
                            items:
                              description: HTTPHeader describes a custom header to
                                be used in HTTP probes
                              properties:
                                name:
                                  description: The header field name
                                  type: string
                                value:
                                  description: The header field value
                                  type: string
                              required:
                              - name
                              - value
                            type: array
                          path:
                            description: Path to access on the HTTP server.
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                          scheme:
                            description: Scheme to use for connecting to the host.
                              Defaults to HTTP.
                            type: string
                        required:
                        - port
                      initialDelaySeconds:
                        description: 'Number of seconds after the container has started
                          before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                      periodSeconds:
                        description: How often (in seconds) to perform the probe.
                          Default to 10 seconds. Minimum value is 1.
                        format: int32
                        type: integer
                      successThreshold:
                        description: Minimum consecutive successes for the probe to
                          be considered successful after having failed. Defaults to
                          1. Must be 1 for liveness. Minimum value is 1.
                        format: int32
                        type: integer
                      tcpSocket:
                        description: TCPSocketAction describes an action based on
                          opening a socket
                        properties:
                          host:
                            description: 'Optional: Host name to connect to, defaults
                              to the pod IP.'
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                        required:
                        - port
                      timeoutSeconds:
                        description: 'Number of seconds after which the probe times
                          out. Defaults to 1 second. Minimum value is 1. More info:
                          https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                  resources:
                    description: ResourceRequirements describes the compute resource
                      requirements.
                    properties:
                      limits:
                        description: 'Limits describes the maximum amount of compute
                          resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                        type: object
                      requests:
                        description: 'Requests describes the minimum amount of compute
                          resources required. If Requests is omitted for a container,
                          it defaults to Limits if that is explicitly specified, otherwise
                          to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                        type: object
                  securityContext:
                    description: SecurityContext holds security configuration that
                      will be applied to a container. Some fields are present in both
                      SecurityContext and PodSecurityContext.  When both are set,
                      the values in SecurityContext take precedence.
                    properties:
                      allowPrivilegeEscalation:
                        description: 'AllowPrivilegeEscalation controls whether a
                          process can gain more privileges than its parent process.
                          This bool directly controls if the no_new_privs flag will
                          be set on the container process. AllowPrivilegeEscalation
                          is true always when the container is: 1) run as Privileged
                          2) has CAP_SYS_ADMIN'
                        type: boolean
                      capabilities:
                        description: Adds and removes POSIX capabilities from running
                          containers.
                        properties:
                          add:
                            description: Added capabilities
                            items:
                              type: string
                            type: array
                          drop:
                            description: Removed capabilities
                            items:
                              type: string
                            type: array
                      privileged:
                        description: Run container in privileged mode. Processes in
                          privileged containers are essentially equivalent to root
                          on the host. Defaults to false.
                        type: boolean
                      procMount:
                        description: procMount denotes the type of proc mount to use
                          for the containers. The default is DefaultProcMount which
                          uses the container runtime defaults for readonly paths and
                          masked paths. This requires the ProcMountType feature flag
                          to be enabled.
                        type: string
                      readOnlyRootFilesystem:
                        description: Whether this container has a read-only root filesystem.
                          Default is false.
                        type: boolean
                      runAsGroup:
                        description: The GID to run the entrypoint of the container
                          process. Uses runtime default if unset. May also be set
                          in PodSecurityContext.  If set in both SecurityContext and
                          PodSecurityContext, the value specified in SecurityContext
                          takes precedence.
                        format: int64
                        type: integer
                      runAsNonRoot:
                        description: Indicates that the container must run as a non-root
                          user. If true, the Kubelet will validate the image at runtime
                          to ensure that it does not run as UID 0 (root) and fail
                          to start the container if it does. If unset or false, no
                          such validation will be performed. May also be set in PodSecurityContext.  If
                          set in both SecurityContext and PodSecurityContext, the
                          value specified in SecurityContext takes precedence.
                        type: boolean
                      runAsUser:
                        description: The UID to run the entrypoint of the container
                          process. Defaults to user specified in image metadata if
                          unspecified. May also be set in PodSecurityContext.  If
                          set in both SecurityContext and PodSecurityContext, the
                          value specified in SecurityContext takes precedence.
                        format: int64
                        type: integer
                      seLinuxOptions:
                        description: SELinuxOptions are the labels to be applied to
                          the container
                        properties:
                          level:
                            description: Level is SELinux level label that applies
                              to the container.
                            type: string
                          role:
                            description: Role is a SELinux role label that applies
                              to the container.
                            type: string
                          type:
                            description: Type is a SELinux type label that applies
                              to the container.
                            type: string
                          user:
                            description: User is a SELinux user label that applies
                              to the container.
                            type: string
                  stdin:
                    description: Whether this container should allocate a buffer for
                      stdin in the container runtime. If this is not set, reads from
                      stdin in the container will always result in EOF. Default is
                      false.
                    type: boolean
                  stdinOnce:
                    description: Whether the container runtime should close the stdin
                      channel after it has been opened by a single attach. When stdin
                      is true the stdin stream will remain open across multiple attach
                      sessions. If stdinOnce is set to true, stdin is opened on container
                      start, is empty until the first client attaches to stdin, and
                      then remains open and accepts data until the client disconnects,
                      at which time stdin is closed and remains closed until the container
                      is restarted. If this flag is false, a container processes that
                      reads from stdin will never receive an EOF. Default is false
                    type: boolean
                  terminationMessagePath:
                    description: 'Optional: Path at which the file to which the container''s
                      termination message will be written is mounted into the container''s
                      filesystem. Message written is intended to be brief final status,
                      such as an assertion failure message. Will be truncated by the
                      node if greater than 4096 bytes. The total message length across
                      all containers will be limited to 12kb. Defaults to /dev/termination-log.
                      Cannot be updated.'
                    type: string
                  terminationMessagePolicy:
                    description: Indicate how the termination message should be populated.
                      File will use the contents of terminationMessagePath to populate
                      the container status message on both success and failure. FallbackToLogsOnError
                      will use the last chunk of container log output if the termination
                      message file is empty and the container exited with an error.
                      The log output is limited to 2048 bytes or 80 lines, whichever
                      is smaller. Defaults to File. Cannot be updated.
                    type: string
                  tty:
                    description: Whether this container should allocate a TTY for
                      itself, also requires 'stdin' to be true. Default is false.
                    type: boolean
                  volumeDevices:
                    description: volumeDevices is the list of block devices to be
                      used by the container. This is an alpha feature and may change
                      in the future.
                    items:
                      description: volumeDevice describes a mapping of a raw block
                        device within a container.
                      properties:
                        devicePath:
                          description: devicePath is the path inside of the container
                            that the device will be mapped to.
                          type: string
                        name:
                          description: name must match the name of a persistentVolumeClaim
                            in the pod
                          type: string
                      required:
                      - name
                      - devicePath
                    type: array
                  volumeMounts:
                    description: Pod volumes to mount into the container's filesystem.
                      Cannot be updated.
                    items:
                      description: VolumeMount describes a mounting of a Volume within
                        a container.
                      properties:
                        mountPath:
                          description: Path within the container at which the volume
                            should be mounted.  Must not contain ':'.
                          type: string
                        mountPropagation:
                          description: mountPropagation determines how mounts are
                            propagated from the host to container and the other way
                            around. When not set, MountPropagationNone is used. This
                            field is beta in 1.10.
                          type: string
                        name:
                          description: This must match the Name of a Volume.
                          type: string
                        readOnly:
                          description: Mounted read-only if true, read-write otherwise
                            (false or unspecified). Defaults to false.
                          type: boolean
                        subPath:
                          description: Path within the volume from which the container's
                            volume should be mounted. Defaults to "" (volume's root).
                          type: string
                      required:
                      - name
                      - mountPath
                    type: array
                  workingDir:
                    description: Container's working directory. If not specified,
                      the container runtime's default will be used, which might be
                      configured in the container image. Cannot be updated.
                    type: string
                required:
                - name
              type: array
            externalUrl:
              description: The external URL the Alertmanager instances will be available
                under. This is necessary to generate correct URLs. This is necessary
                if Alertmanager is not served from root of a DNS name.
              type: string
            image:
              description: Image if specified has precedence over baseImage, tag and
                sha combinations. Specifying the version is still necessary to ensure
                the Prometheus Operator knows what version of Alertmanager is being
                configured.
              type: string
            imagePullSecrets:
              description: An optional list of references to secrets in the same namespace
                to use for pulling prometheus and alertmanager images from registries
                see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod
              items:
                description: LocalObjectReference contains enough information to let
                  you locate the referenced object inside the same namespace.
                properties:
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
              type: array
            listenLocal:
              description: ListenLocal makes the Alertmanager server listen on loopback,
                so that it does not bind against the Pod IP. Note this is only for
                the Alertmanager UI, not the gossip communication.
              type: boolean
            logLevel:
              description: Log level for Alertmanager to be configured with.
              type: string
            nodeSelector:
              description: Define which Nodes the Pods are scheduled on.
              type: object
            paused:
              description: If set to true all actions on the underlaying managed objects
                are not goint to be performed, except for delete actions.
              type: boolean
            podMetadata:
              description: ObjectMeta is metadata that all persisted resources must
                have, which includes all objects users must create.
              properties:
                annotations:
                  description: 'Annotations is an unstructured key value map stored
                    with a resource that may be set by external tools to store and
                    retrieve arbitrary metadata. They are not queryable and should
                    be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations'
                  type: object
                clusterName:
                  description: The name of the cluster which the object belongs to.
                    This is used to distinguish resources with same name and namespace
                    in different clusters. This field is not set anywhere right now
                    and apiserver is going to ignore it if set in create or update
                    request.
                  type: string
                creationTimestamp:
                  description: Time is a wrapper around time.Time which supports correct
                    marshaling to YAML and JSON.  Wrappers are provided for many of
                    the factory methods that the time package offers.
                  format: date-time
                  type: string
                deletionGracePeriodSeconds:
                  description: Number of seconds allowed for this object to gracefully
                    terminate before it will be removed from the system. Only set
                    when deletionTimestamp is also set. May only be shortened. Read-only.
                  format: int64
                  type: integer
                deletionTimestamp:
                  description: Time is a wrapper around time.Time which supports correct
                    marshaling to YAML and JSON.  Wrappers are provided for many of
                    the factory methods that the time package offers.
                  format: date-time
                  type: string
                finalizers:
                  description: Must be empty before the object is deleted from the
                    registry. Each entry is an identifier for the responsible component
                    that will remove the entry from the list. If the deletionTimestamp
                    of the object is non-nil, entries in this list can only be removed.
                  items:
                    type: string
                  type: array
                generateName:
                  description: |-
                    GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.

                    If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).

                    Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
                  type: string
                generation:
                  description: A sequence number representing a specific generation
                    of the desired state. Populated by the system. Read-only.
                  format: int64
                  type: integer
                initializers:
                  description: Initializers tracks the progress of initialization.
                  properties:
                    pending:
                      description: Pending is a list of initializers that must execute
                        in order before this object is visible. When the last pending
                        initializer is removed, and no failing result is set, the
                        initializers struct will be set to nil and the object is considered
                        as initialized and visible to all clients.
                      items:
                        description: Initializer is information about an initializer
                          that has not yet completed.
                        properties:
                          name:
                            description: name of the process that is responsible for
                              initializing this object.
                            type: string
                        required:
                        - name
                      type: array
                    result:
                      description: Status is a return value for calls that don't return
                        other objects.
                      properties:
                        apiVersion:
                          description: 'APIVersion defines the versioned schema of
                            this representation of an object. Servers should convert
                            recognized schemas to the latest internal value, and may
                            reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                          type: string
                        code:
                          description: Suggested HTTP return code for this status,
                            0 if not set.
                          format: int32
                          type: integer
                        details:
                          description: StatusDetails is a set of additional properties
                            that MAY be set by the server to provide additional information
                            about a response. The Reason field of a Status object
                            defines what attributes will be set. Clients must ignore
                            fields that do not match the defined type of each attribute,
                            and should assume that any attribute may be empty, invalid,
                            or under defined.
                          properties:
                            causes:
                              description: The Causes array includes more details
                                associated with the StatusReason failure. Not all
                                StatusReasons may provide detailed causes.
                              items:
                                description: StatusCause provides more information
                                  about an api.Status failure, including cases when
                                  multiple errors are encountered.
                                properties:
                                  field:
                                    description: |-
                                      The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

                                      Examples:
                                        "name" - the field "name" on the current resource
                                        "items[0].name" - the field "name" on the first array entry in "items"
                                    type: string
                                  message:
                                    description: A human-readable description of the
                                      cause of the error.  This field may be presented
                                      as-is to a reader.
                                    type: string
                                  reason:
                                    description: A machine-readable description of
                                      the cause of the error. If this value is empty
                                      there is no information available.
                                    type: string
                              type: array
                            group:
                              description: The group attribute of the resource associated
                                with the status StatusReason.
                              type: string
                            kind:
                              description: 'The kind attribute of the resource associated
                                with the status StatusReason. On some operations may
                                differ from the requested resource Kind. More info:
                                https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                              type: string
                            name:
                              description: The name attribute of the resource associated
                                with the status StatusReason (when there is a single
                                name which can be described).
                              type: string
                            retryAfterSeconds:
                              description: If specified, the time in seconds before
                                the operation should be retried. Some errors may indicate
                                the client must take an alternate action - for those
                                errors this field may indicate how long to wait before
                                taking the alternate action.
                              format: int32
                              type: integer
                            uid:
                              description: 'UID of the resource. (when there is a
                                single resource which can be described). More info:
                                http://kubernetes.io/docs/user-guide/identifiers#uids'
                              type: string
                        kind:
                          description: 'Kind is a string value representing the REST
                            resource this object represents. Servers may infer this
                            from the endpoint the client submits requests to. Cannot
                            be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                          type: string
                        message:
                          description: A human-readable description of the status
                            of this operation.
                          type: string
                        metadata:
                          description: ListMeta describes metadata that synthetic
                            resources must have, including lists and various status
                            objects. A resource may have only one of {ObjectMeta,
                            ListMeta}.
                          properties:
                            continue:
                              description: continue may be set if the user set a limit
                                on the number of items returned, and indicates that
                                the server has more data available. The value is opaque
                                and may be used to issue another request to the endpoint
                                that served this list to retrieve the next set of
                                available objects. Continuing a consistent list may
                                not be possible if the server configuration has changed
                                or more than a few minutes have passed. The resourceVersion
                                field returned when using this continue value will
                                be identical to the value in the first response, unless
                                you have received this token from an error message.
                              type: string
                            resourceVersion:
                              description: 'String that identifies the server''s internal
                                version of this object that can be used by clients
                                to determine when objects have changed. Value must
                                be treated as opaque by clients and passed unmodified
                                back to the server. Populated by the system. Read-only.
                                More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency'
                              type: string
                            selfLink:
                              description: selfLink is a URL representing this object.
                                Populated by the system. Read-only.
                              type: string
                        reason:
                          description: A machine-readable description of why this
                            operation is in the "Failure" status. If this value is
                            empty there is no information available. A Reason clarifies
                            an HTTP status code but does not override it.
                          type: string
                        status:
                          description: 'Status of the operation. One of: "Success"
                            or "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status'
                          type: string
                  required:
                  - pending
                labels:
                  description: 'Map of string keys and values that can be used to
                    organize and categorize (scope and select) objects. May match
                    selectors of replication controllers and services. More info:
                    http://kubernetes.io/docs/user-guide/labels'
                  type: object
                name:
                  description: 'Name must be unique within a namespace. Is required
                    when creating resources, although some resources may allow a client
                    to request the generation of an appropriate name automatically.
                    Name is primarily intended for creation idempotence and configuration
                    definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                  type: string
                namespace:
                  description: |-
                    Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.

                    Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
                  type: string
                ownerReferences:
                  description: List of objects depended by this object. If ALL objects
                    in the list have been deleted, this object will be garbage collected.
                    If this object is managed by a controller, then an entry in this
                    list will point to this controller, with the controller field
                    set to true. There cannot be more than one managing controller.
                  items:
                    description: OwnerReference contains enough information to let
                      you identify an owning object. Currently, an owning object must
                      be in the same namespace, so there is no namespace field.
                    properties:
                      apiVersion:
                        description: API version of the referent.
                        type: string
                      blockOwnerDeletion:
                        description: If true, AND if the owner has the "foregroundDeletion"
                          finalizer, then the owner cannot be deleted from the key-value
                          store until this reference is removed. Defaults to false.
                          To set this field, a user needs "delete" permission of the
                          owner, otherwise 422 (Unprocessable Entity) will be returned.
                        type: boolean
                      controller:
                        description: If true, this reference points to the managing
                          controller.
                        type: boolean
                      kind:
                        description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                        type: string
                      name:
                        description: 'Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                        type: string
                      uid:
                        description: 'UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                        type: string
                    required:
                    - apiVersion
                    - kind
                    - name
                    - uid
                  type: array
                resourceVersion:
                  description: |-
                    An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.

                    Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
                  type: string
                selfLink:
                  description: SelfLink is a URL representing this object. Populated
                    by the system. Read-only.
                  type: string
                uid:
                  description: |-
                    UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.

                    Populated by the system. Read-only. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
                  type: string
            priorityClassName:
              description: Priority class assigned to the Pods
              type: string
            replicas:
              description: Size is the expected size of the alertmanager cluster.
                The controller will eventually make the size of the running cluster
                equal to the expected size.
              format: int32
              type: integer
            resources:
              description: ResourceRequirements describes the compute resource requirements.
              properties:
                limits:
                  description: 'Limits describes the maximum amount of compute resources
                    allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                  type: object
                requests:
                  description: 'Requests describes the minimum amount of compute resources
                    required. If Requests is omitted for a container, it defaults
                    to Limits if that is explicitly specified, otherwise to an implementation-defined
                    value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                  type: object
            retention:
              description: Time duration Alertmanager shall retain data for. Default
                is '120h', and must match the regular expression `[0-9]+(ms|s|m|h)`
                (milliseconds seconds minutes hours).
              type: string
            routePrefix:
              description: The route prefix Alertmanager registers HTTP handlers for.
                This is useful, if using ExternalURL and a proxy is rewriting HTTP
                routes of a request, and the actual ExternalURL is still true, but
                the server serves requests under a different route prefix. For example
                for use with `kubectl proxy`.
              type: string
            secrets:
              description: Secrets is a list of Secrets in the same namespace as the
                Alertmanager object, which shall be mounted into the Alertmanager
                Pods. The Secrets are mounted into /etc/alertmanager/secrets/<secret-name>.
              items:
                type: string
              type: array
            securityContext:
              description: PodSecurityContext holds pod-level security attributes
                and common container settings. Some fields are also present in container.securityContext.  Field
                values of container.securityContext take precedence over field values
                of PodSecurityContext.
              properties:
                fsGroup:
                  description: |-
                    A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:

                    1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----

                    If unset, the Kubelet will not modify the ownership and permissions of any volume.
                  format: int64
                  type: integer
                runAsGroup:
                  description: The GID to run the entrypoint of the container process.
                    Uses runtime default if unset. May also be set in SecurityContext.  If
                    set in both SecurityContext and PodSecurityContext, the value
                    specified in SecurityContext takes precedence for that container.
                  format: int64
                  type: integer
                runAsNonRoot:
                  description: Indicates that the container must run as a non-root
                    user. If true, the Kubelet will validate the image at runtime
                    to ensure that it does not run as UID 0 (root) and fail to start
                    the container if it does. If unset or false, no such validation
                    will be performed. May also be set in SecurityContext.  If set
                    in both SecurityContext and PodSecurityContext, the value specified
                    in SecurityContext takes precedence.
                  type: boolean
                runAsUser:
                  description: The UID to run the entrypoint of the container process.
                    Defaults to user specified in image metadata if unspecified. May
                    also be set in SecurityContext.  If set in both SecurityContext
                    and PodSecurityContext, the value specified in SecurityContext
                    takes precedence for that container.
                  format: int64
                  type: integer
                seLinuxOptions:
                  description: SELinuxOptions are the labels to be applied to the
                    container
                  properties:
                    level:
                      description: Level is SELinux level label that applies to the
                        container.
                      type: string
                    role:
                      description: Role is a SELinux role label that applies to the
                        container.
                      type: string
                    type:
                      description: Type is a SELinux type label that applies to the
                        container.
                      type: string
                    user:
                      description: User is a SELinux user label that applies to the
                        container.
                      type: string
                supplementalGroups:
                  description: A list of groups applied to the first process run in
                    each container, in addition to the container's primary GID.  If
                    unspecified, no groups will be added to any container.
                  items:
                    format: int64
                    type: integer
                  type: array
                sysctls:
                  description: Sysctls hold a list of namespaced sysctls used for
                    the pod. Pods with unsupported sysctls (by the container runtime)
                    might fail to launch.
                  items:
                    description: Sysctl defines a kernel parameter to be set
                    properties:
                      name:
                        description: Name of a property to set
                        type: string
                      value:
                        description: Value of a property to set
                        type: string
                    required:
                    - name
                    - value
                  type: array
            serviceAccountName:
              description: ServiceAccountName is the name of the ServiceAccount to
                use to run the Prometheus Pods.
              type: string
            sha:
              description: SHA of Alertmanager container image to be deployed. Defaults
                to the value of `version`. Similar to a tag, but the SHA explicitly
                deploys an immutable container image. Version and Tag are ignored
                if SHA is set.
              type: string
            storage:
              description: StorageSpec defines the configured storage for a group
                Prometheus servers. If neither `emptyDir` nor `volumeClaimTemplate`
                is specified, then by default an [EmptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
                will be used.
              properties:
                emptyDir:
                  description: Represents an empty directory for a pod. Empty directory
                    volumes support ownership management and SELinux relabeling.
                  properties:
                    medium:
                      description: 'What type of storage medium should back this directory.
                        The default is "" which means to use the node''s default medium.
                        Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir'
                      type: string
                    sizeLimit: {}
                volumeClaimTemplate:
                  description: PersistentVolumeClaim is a user's request for and claim
                    to a persistent volume
                  properties:
                    apiVersion:
                      description: 'APIVersion defines the versioned schema of this
                        representation of an object. Servers should convert recognized
                        schemas to the latest internal value, and may reject unrecognized
                        values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                      type: string
                    kind:
                      description: 'Kind is a string value representing the REST resource
                        this object represents. Servers may infer this from the endpoint
                        the client submits requests to. Cannot be updated. In CamelCase.
                        More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                      type: string
                    metadata:
                      description: ObjectMeta is metadata that all persisted resources
                        must have, which includes all objects users must create.
                      properties:
                        annotations:
                          description: 'Annotations is an unstructured key value map
                            stored with a resource that may be set by external tools
                            to store and retrieve arbitrary metadata. They are not
                            queryable and should be preserved when modifying objects.
                            More info: http://kubernetes.io/docs/user-guide/annotations'
                          type: object
                        clusterName:
                          description: The name of the cluster which the object belongs
                            to. This is used to distinguish resources with same name
                            and namespace in different clusters. This field is not
                            set anywhere right now and apiserver is going to ignore
                            it if set in create or update request.
                          type: string
                        creationTimestamp:
                          description: Time is a wrapper around time.Time which supports
                            correct marshaling to YAML and JSON.  Wrappers are provided
                            for many of the factory methods that the time package
                            offers.
                          format: date-time
                          type: string
                        deletionGracePeriodSeconds:
                          description: Number of seconds allowed for this object to
                            gracefully terminate before it will be removed from the
                            system. Only set when deletionTimestamp is also set. May
                            only be shortened. Read-only.
                          format: int64
                          type: integer
                        deletionTimestamp:
                          description: Time is a wrapper around time.Time which supports
                            correct marshaling to YAML and JSON.  Wrappers are provided
                            for many of the factory methods that the time package
                            offers.
                          format: date-time
                          type: string
                        finalizers:
                          description: Must be empty before the object is deleted
                            from the registry. Each entry is an identifier for the
                            responsible component that will remove the entry from
                            the list. If the deletionTimestamp of the object is non-nil,
                            entries in this list can only be removed.
                          items:
                            type: string
                          type: array
                        generateName:
                          description: |-
                            GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.

                            If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).

                            Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
                          type: string
                        generation:
                          description: A sequence number representing a specific generation
                            of the desired state. Populated by the system. Read-only.
                          format: int64
                          type: integer
                        initializers:
                          description: Initializers tracks the progress of initialization.
                          properties:
                            pending:
                              description: Pending is a list of initializers that
                                must execute in order before this object is visible.
                                When the last pending initializer is removed, and
                                no failing result is set, the initializers struct
                                will be set to nil and the object is considered as
                                initialized and visible to all clients.
                              items:
                                description: Initializer is information about an initializer
                                  that has not yet completed.
                                properties:
                                  name:
                                    description: name of the process that is responsible
                                      for initializing this object.
                                    type: string
                                required:
                                - name
                              type: array
                            result:
                              description: Status is a return value for calls that
                                don't return other objects.
                              properties:
                                apiVersion:
                                  description: 'APIVersion defines the versioned schema
                                    of this representation of an object. Servers should
                                    convert recognized schemas to the latest internal
                                    value, and may reject unrecognized values. More
                                    info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                                  type: string
                                code:
                                  description: Suggested HTTP return code for this
                                    status, 0 if not set.
                                  format: int32
                                  type: integer
                                details:
                                  description: StatusDetails is a set of additional
                                    properties that MAY be set by the server to provide
                                    additional information about a response. The Reason
                                    field of a Status object defines what attributes
                                    will be set. Clients must ignore fields that do
                                    not match the defined type of each attribute,
                                    and should assume that any attribute may be empty,
                                    invalid, or under defined.
                                  properties:
                                    causes:
                                      description: The Causes array includes more
                                        details associated with the StatusReason failure.
                                        Not all StatusReasons may provide detailed
                                        causes.
                                      items:
                                        description: StatusCause provides more information
                                          about an api.Status failure, including cases
                                          when multiple errors are encountered.
                                        properties:
                                          field:
                                            description: |-
                                              The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

                                              Examples:
                                                "name" - the field "name" on the current resource
                                                "items[0].name" - the field "name" on the first array entry in "items"
                                            type: string
                                          message:
                                            description: A human-readable description
                                              of the cause of the error.  This field
                                              may be presented as-is to a reader.
                                            type: string
                                          reason:
                                            description: A machine-readable description
                                              of the cause of the error. If this value
                                              is empty there is no information available.
                                            type: string
                                      type: array
                                    group:
                                      description: The group attribute of the resource
                                        associated with the status StatusReason.
                                      type: string
                                    kind:
                                      description: 'The kind attribute of the resource
                                        associated with the status StatusReason. On
                                        some operations may differ from the requested
                                        resource Kind. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                      type: string
                                    name:
                                      description: The name attribute of the resource
                                        associated with the status StatusReason (when
                                        there is a single name which can be described).
                                      type: string
                                    retryAfterSeconds:
                                      description: If specified, the time in seconds
                                        before the operation should be retried. Some
                                        errors may indicate the client must take an
                                        alternate action - for those errors this field
                                        may indicate how long to wait before taking
                                        the alternate action.
                                      format: int32
                                      type: integer
                                    uid:
                                      description: 'UID of the resource. (when there
                                        is a single resource which can be described).
                                        More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                                      type: string
                                kind:
                                  description: 'Kind is a string value representing
                                    the REST resource this object represents. Servers
                                    may infer this from the endpoint the client submits
                                    requests to. Cannot be updated. In CamelCase.
                                    More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                  type: string
                                message:
                                  description: A human-readable description of the
                                    status of this operation.
                                  type: string
                                metadata:
                                  description: ListMeta describes metadata that synthetic
                                    resources must have, including lists and various
                                    status objects. A resource may have only one of
                                    {ObjectMeta, ListMeta}.
                                  properties:
                                    continue:
                                      description: continue may be set if the user
                                        set a limit on the number of items returned,
                                        and indicates that the server has more data
                                        available. The value is opaque and may be
                                        used to issue another request to the endpoint
                                        that served this list to retrieve the next
                                        set of available objects. Continuing a consistent
                                        list may not be possible if the server configuration
                                        has changed or more than a few minutes have
                                        passed. The resourceVersion field returned
                                        when using this continue value will be identical
                                        to the value in the first response, unless
                                        you have received this token from an error
                                        message.
                                      type: string
                                    resourceVersion:
                                      description: 'String that identifies the server''s
                                        internal version of this object that can be
                                        used by clients to determine when objects
                                        have changed. Value must be treated as opaque
                                        by clients and passed unmodified back to the
                                        server. Populated by the system. Read-only.
                                        More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency'
                                      type: string
                                    selfLink:
                                      description: selfLink is a URL representing
                                        this object. Populated by the system. Read-only.
                                      type: string
                                reason:
                                  description: A machine-readable description of why
                                    this operation is in the "Failure" status. If
                                    this value is empty there is no information available.
                                    A Reason clarifies an HTTP status code but does
                                    not override it.
                                  type: string
                                status:
                                  description: 'Status of the operation. One of: "Success"
                                    or "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status'
                                  type: string
                          required:
                          - pending
                        labels:
                          description: 'Map of string keys and values that can be
                            used to organize and categorize (scope and select) objects.
                            May match selectors of replication controllers and services.
                            More info: http://kubernetes.io/docs/user-guide/labels'
                          type: object
                        name:
                          description: 'Name must be unique within a namespace. Is
                            required when creating resources, although some resources
                            may allow a client to request the generation of an appropriate
                            name automatically. Name is primarily intended for creation
                            idempotence and configuration definition. Cannot be updated.
                            More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                          type: string
                        namespace:
                          description: |-
                            Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.

                            Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
                          type: string
                        ownerReferences:
                          description: List of objects depended by this object. If
                            ALL objects in the list have been deleted, this object
                            will be garbage collected. If this object is managed by
                            a controller, then an entry in this list will point to
                            this controller, with the controller field set to true.
                            There cannot be more than one managing controller.
                          items:
                            description: OwnerReference contains enough information
                              to let you identify an owning object. Currently, an
                              owning object must be in the same namespace, so there
                              is no namespace field.
                            properties:
                              apiVersion:
                                description: API version of the referent.
                                type: string
                              blockOwnerDeletion:
                                description: If true, AND if the owner has the "foregroundDeletion"
                                  finalizer, then the owner cannot be deleted from
                                  the key-value store until this reference is removed.
                                  Defaults to false. To set this field, a user needs
                                  "delete" permission of the owner, otherwise 422
                                  (Unprocessable Entity) will be returned.
                                type: boolean
                              controller:
                                description: If true, this reference points to the
                                  managing controller.
                                type: boolean
                              kind:
                                description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                type: string
                              name:
                                description: 'Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                                type: string
                              uid:
                                description: 'UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                                type: string
                            required:
                            - apiVersion
                            - kind
                            - name
                            - uid
                          type: array
                        resourceVersion:
                          description: |-
                            An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.

                            Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
                          type: string
                        selfLink:
                          description: SelfLink is a URL representing this object.
                            Populated by the system. Read-only.
                          type: string
                        uid:
                          description: |-
                            UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.

                            Populated by the system. Read-only. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
                          type: string
                    spec:
                      description: PersistentVolumeClaimSpec describes the common
                        attributes of storage devices and allows a Source for provider-specific
                        attributes
                      properties:
                        accessModes:
                          description: 'AccessModes contains the desired access modes
                            the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1'
                          items:
                            type: string
                          type: array
                        dataSource:
                          description: TypedLocalObjectReference contains enough information
                            to let you locate the typed referenced object inside the
                            same namespace.
                          properties:
                            apiGroup:
                              description: APIGroup is the group for the resource
                                being referenced. If APIGroup is not specified, the
                                specified Kind must be in the core API group. For
                                any other third-party types, APIGroup is required.
                              type: string
                            kind:
                              description: Kind is the type of resource being referenced
                              type: string
                            name:
                              description: Name is the name of resource being referenced
                              type: string
                          required:
                          - kind
                          - name
                        resources:
                          description: ResourceRequirements describes the compute
                            resource requirements.
                          properties:
                            limits:
                              description: 'Limits describes the maximum amount of
                                compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                              type: object
                            requests:
                              description: 'Requests describes the minimum amount
                                of compute resources required. If Requests is omitted
                                for a container, it defaults to Limits if that is
                                explicitly specified, otherwise to an implementation-defined
                                value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                              type: object
                        selector:
                          description: A label selector is a label query over a set
                            of resources. The result of matchLabels and matchExpressions
                            are ANDed. An empty label selector matches all objects.
                            A null label selector matches no objects.
                          properties:
                            matchExpressions:
                              description: matchExpressions is a list of label selector
                                requirements. The requirements are ANDed.
                              items:
                                description: A label selector requirement is a selector
                                  that contains values, a key, and an operator that
                                  relates the key and values.
                                properties:
                                  key:
                                    description: key is the label key that the selector
                                      applies to.
                                    type: string
                                  operator:
                                    description: operator represents a key's relationship
                                      to a set of values. Valid operators are In,
                                      NotIn, Exists and DoesNotExist.
                                    type: string
                                  values:
                                    description: values is an array of string values.
                                      If the operator is In or NotIn, the values array
                                      must be non-empty. If the operator is Exists
                                      or DoesNotExist, the values array must be empty.
                                      This array is replaced during a strategic merge
                                      patch.
                                    items:
                                      type: string
                                    type: array
                                required:
                                - key
                                - operator
                              type: array
                            matchLabels:
                              description: matchLabels is a map of {key,value} pairs.
                                A single {key,value} in the matchLabels map is equivalent
                                to an element of matchExpressions, whose key field
                                is "key", the operator is "In", and the values array
                                contains only "value". The requirements are ANDed.
                              type: object
                        storageClassName:
                          description: 'Name of the StorageClass required by the claim.
                            More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1'
                          type: string
                        volumeMode:
                          description: volumeMode defines what type of volume is required
                            by the claim. Value of Filesystem is implied when not
                            included in claim spec. This is an alpha feature and may
                            change in the future.
                          type: string
                        volumeName:
                          description: VolumeName is the binding reference to the
                            PersistentVolume backing this claim.
                          type: string
                    status:
                      description: PersistentVolumeClaimStatus is the current status
                        of a persistent volume claim.
                      properties:
                        accessModes:
                          description: 'AccessModes contains the actual access modes
                            the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1'
                          items:
                            type: string
                          type: array
                        capacity:
                          description: Represents the actual resources of the underlying
                            volume.
                          type: object
                        conditions:
                          description: Current Condition of persistent volume claim.
                            If underlying persistent volume is being resized then
                            the Condition will be set to 'ResizeStarted'.
                          items:
                            description: PersistentVolumeClaimCondition contails details
                              about state of pvc
                            properties:
                              lastProbeTime:
                                description: Time is a wrapper around time.Time which
                                  supports correct marshaling to YAML and JSON.  Wrappers
                                  are provided for many of the factory methods that
                                  the time package offers.
                                format: date-time
                                type: string
                              lastTransitionTime:
                                description: Time is a wrapper around time.Time which
                                  supports correct marshaling to YAML and JSON.  Wrappers
                                  are provided for many of the factory methods that
                                  the time package offers.
                                format: date-time
                                type: string
                              message:
                                description: Human-readable message indicating details
                                  about last transition.
                                type: string
                              reason:
                                description: Unique, this should be a short, machine
                                  understandable string that gives the reason for
                                  condition's last transition. If it reports "ResizeStarted"
                                  that means the underlying persistent volume is being
                                  resized.
                                type: string
                              status:
                                type: string
                              type:
                                type: string
                            required:
                            - type
                            - status
                          type: array
                        phase:
                          description: Phase represents the current phase of PersistentVolumeClaim.
                          type: string
            tag:
              description: Tag of Alertmanager container image to be deployed. Defaults
                to the value of `version`. Version is ignored if Tag is set.
              type: string
            tolerations:
              description: If specified, the pod's tolerations.
              items:
                description: The pod this Toleration is attached to tolerates any
                  taint that matches the triple <key,value,effect> using the matching
                  operator <operator>.
                properties:
                  effect:
                    description: Effect indicates the taint effect to match. Empty
                      means match all taint effects. When specified, allowed values
                      are NoSchedule, PreferNoSchedule and NoExecute.
                    type: string
                  key:
                    description: Key is the taint key that the toleration applies
                      to. Empty means match all taint keys. If the key is empty, operator
                      must be Exists; this combination means to match all values and
                      all keys.
                    type: string
                  operator:
                    description: Operator represents a key's relationship to the value.
                      Valid operators are Exists and Equal. Defaults to Equal. Exists
                      is equivalent to wildcard for value, so that a pod can tolerate
                      all taints of a particular category.
                    type: string
                  tolerationSeconds:
                    description: TolerationSeconds represents the period of time the
                      toleration (which must be of effect NoExecute, otherwise this
                      field is ignored) tolerates the taint. By default, it is not
                      set, which means tolerate the taint forever (do not evict).
                      Zero and negative values will be treated as 0 (evict immediately)
                      by the system.
                    format: int64
                    type: integer
                  value:
                    description: Value is the taint value the toleration matches to.
                      If the operator is Exists, the value should be empty, otherwise
                      just a regular string.
                    type: string
              type: array
            version:
              description: Version the cluster should be on.
              type: string
        status:
          description: 'AlertmanagerStatus is the most recent observed status of the
            Alertmanager cluster. Read-only. Not included when requesting from the
            apiserver, only from the Prometheus Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md#spec-and-status'
          properties:
            availableReplicas:
              description: Total number of available pods (ready for at least minReadySeconds)
                targeted by this Alertmanager cluster.
              format: int32
              type: integer
            paused:
              description: Represents whether any actions on the underlaying managed
                objects are being performed. Only delete actions will be performed.
              type: boolean
            replicas:
              description: Total number of non-terminated pods targeted by this Alertmanager
                cluster (their labels match the selector).
              format: int32
              type: integer
            unavailableReplicas:
              description: Total number of unavailable pods targeted by this Alertmanager
                cluster.
              format: int32
              type: integer
            updatedReplicas:
              description: Total number of non-terminated pods targeted by this Alertmanager
                cluster that have the desired version spec.
              format: int32
              type: integer
          required:
          - paused
          - replicas
          - updatedReplicas
          - availableReplicas
          - unavailableReplicas
  version: v1
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  creationTimestamp: null
  name: prometheuses.monitoring.coreos.com
spec:
  group: monitoring.coreos.com
  names:
    kind: Prometheus
    plural: prometheuses
  scope: Namespaced
  validation:
    openAPIV3Schema:
      properties:
        apiVersion:
          description: 'APIVersion defines the versioned schema of this representation
            of an object. Servers should convert recognized schemas to the latest
            internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
          type: string
        kind:
          description: 'Kind is a string value representing the REST resource this
            object represents. Servers may infer this from the endpoint the client
            submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
          type: string
        spec:
          description: 'PrometheusSpec is a specification of the desired behavior
            of the Prometheus cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md#spec-and-status'
          properties:
            additionalAlertManagerConfigs:
              description: SecretKeySelector selects a key of a Secret.
              properties:
                key:
                  description: The key of the secret to select from.  Must be a valid
                    secret key.
                  type: string
                name:
                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                  type: string
                optional:
                  description: Specify whether the Secret or it's key must be defined
                  type: boolean
              required:
              - key
            additionalAlertRelabelConfigs:
              description: SecretKeySelector selects a key of a Secret.
              properties:
                key:
                  description: The key of the secret to select from.  Must be a valid
                    secret key.
                  type: string
                name:
                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                  type: string
                optional:
                  description: Specify whether the Secret or it's key must be defined
                  type: boolean
              required:
              - key
            additionalScrapeConfigs:
              description: SecretKeySelector selects a key of a Secret.
              properties:
                key:
                  description: The key of the secret to select from.  Must be a valid
                    secret key.
                  type: string
                name:
                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                  type: string
                optional:
                  description: Specify whether the Secret or it's key must be defined
                  type: boolean
              required:
              - key
            affinity:
              description: Affinity is a group of affinity scheduling rules.
              properties:
                nodeAffinity:
                  description: Node affinity is a group of node affinity scheduling
                    rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the affinity expressions specified by this field,
                        but it may choose a node that violates one or more of the
                        expressions. The node that is most preferred is the one with
                        the greatest sum of weights, i.e. for each node that meets
                        all of the scheduling requirements (resource request, requiredDuringScheduling
                        affinity expressions, etc.), compute a sum by iterating through
                        the elements of this field and adding "weight" to the sum
                        if the node matches the corresponding matchExpressions; the
                        node(s) with the highest sum are the most preferred.
                      items:
                        description: An empty preferred scheduling term matches all
                          objects with implicit weight 0 (i.e. it's a no-op). A null
                          preferred scheduling term matches no objects (i.e. is also
                          a no-op).
                        properties:
                          preference:
                            description: A null or empty node selector term matches
                              no objects. The requirements of them are ANDed. The
                              TopologySelectorTerm type implements a subset of the
                              NodeSelectorTerm.
                            properties:
                              matchExpressions:
                                description: A list of node selector requirements
                                  by node's labels.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchFields:
                                description: A list of node selector requirements
                                  by node's fields.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                          weight:
                            description: Weight associated with matching the corresponding
                              nodeSelectorTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - preference
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: A node selector represents the union of the results
                        of one or more label queries over a set of nodes; that is,
                        it represents the OR of the selectors represented by the node
                        selector terms.
                      properties:
                        nodeSelectorTerms:
                          description: Required. A list of node selector terms. The
                            terms are ORed.
                          items:
                            description: A null or empty node selector term matches
                              no objects. The requirements of them are ANDed. The
                              TopologySelectorTerm type implements a subset of the
                              NodeSelectorTerm.
                            properties:
                              matchExpressions:
                                description: A list of node selector requirements
                                  by node's labels.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchFields:
                                description: A list of node selector requirements
                                  by node's fields.
                                items:
                                  description: A node selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: The label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: Represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists, DoesNotExist. Gt, and Lt.
                                      type: string
                                    values:
                                      description: An array of string values. If the
                                        operator is In or NotIn, the values array
                                        must be non-empty. If the operator is Exists
                                        or DoesNotExist, the values array must be
                                        empty. If the operator is Gt or Lt, the values
                                        array must have a single element, which will
                                        be interpreted as an integer. This array is
                                        replaced during a strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                          type: array
                      required:
                      - nodeSelectorTerms
                podAffinity:
                  description: Pod affinity is a group of inter pod affinity scheduling
                    rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the affinity expressions specified by this field,
                        but it may choose a node that violates one or more of the
                        expressions. The node that is most preferred is the one with
                        the greatest sum of weights, i.e. for each node that meets
                        all of the scheduling requirements (resource request, requiredDuringScheduling
                        affinity expressions, etc.), compute a sum by iterating through
                        the elements of this field and adding "weight" to the sum
                        if the node has pods which matches the corresponding podAffinityTerm;
                        the node(s) with the highest sum are the most preferred.
                      items:
                        description: The weights of all of the matched WeightedPodAffinityTerm
                          fields are added per-node to find the most preferred node(s)
                        properties:
                          podAffinityTerm:
                            description: Defines a set of pods (namely those matching
                              the labelSelector relative to the given namespace(s))
                              that this pod should be co-located (affinity) or not
                              co-located (anti-affinity) with, where co-located is
                              defined as running on a node whose value of the label
                              with key <topologyKey> matches that of any node on which
                              a pod of the set of pods is running
                            properties:
                              labelSelector:
                                description: A label selector is a label query over
                                  a set of resources. The result of matchLabels and
                                  matchExpressions are ANDed. An empty label selector
                                  matches all objects. A null label selector matches
                                  no objects.
                                properties:
                                  matchExpressions:
                                    description: matchExpressions is a list of label
                                      selector requirements. The requirements are
                                      ANDed.
                                    items:
                                      description: A label selector requirement is
                                        a selector that contains values, a key, and
                                        an operator that relates the key and values.
                                      properties:
                                        key:
                                          description: key is the label key that the
                                            selector applies to.
                                          type: string
                                        operator:
                                          description: operator represents a key's
                                            relationship to a set of values. Valid
                                            operators are In, NotIn, Exists and DoesNotExist.
                                          type: string
                                        values:
                                          description: values is an array of string
                                            values. If the operator is In or NotIn,
                                            the values array must be non-empty. If
                                            the operator is Exists or DoesNotExist,
                                            the values array must be empty. This array
                                            is replaced during a strategic merge patch.
                                          items:
                                            type: string
                                          type: array
                                      required:
                                      - key
                                      - operator
                                    type: array
                                  matchLabels:
                                    description: matchLabels is a map of {key,value}
                                      pairs. A single {key,value} in the matchLabels
                                      map is equivalent to an element of matchExpressions,
                                      whose key field is "key", the operator is "In",
                                      and the values array contains only "value".
                                      The requirements are ANDed.
                                    type: object
                              namespaces:
                                description: namespaces specifies which namespaces
                                  the labelSelector applies to (matches against);
                                  null or empty list means "this pod's namespace"
                                items:
                                  type: string
                                type: array
                              topologyKey:
                                description: This pod should be co-located (affinity)
                                  or not co-located (anti-affinity) with the pods
                                  matching the labelSelector in the specified namespaces,
                                  where co-located is defined as running on a node
                                  whose value of the label with key topologyKey matches
                                  that of any node on which any of the selected pods
                                  is running. Empty topologyKey is not allowed.
                                type: string
                            required:
                            - topologyKey
                          weight:
                            description: weight associated with matching the corresponding
                              podAffinityTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - podAffinityTerm
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: If the affinity requirements specified by this
                        field are not met at scheduling time, the pod will not be
                        scheduled onto the node. If the affinity requirements specified
                        by this field cease to be met at some point during pod execution
                        (e.g. due to a pod label update), the system may or may not
                        try to eventually evict the pod from its node. When there
                        are multiple elements, the lists of nodes corresponding to
                        each podAffinityTerm are intersected, i.e. all terms must
                        be satisfied.
                      items:
                        description: Defines a set of pods (namely those matching
                          the labelSelector relative to the given namespace(s)) that
                          this pod should be co-located (affinity) or not co-located
                          (anti-affinity) with, where co-located is defined as running
                          on a node whose value of the label with key <topologyKey>
                          matches that of any node on which a pod of the set of pods
                          is running
                        properties:
                          labelSelector:
                            description: A label selector is a label query over a
                              set of resources. The result of matchLabels and matchExpressions
                              are ANDed. An empty label selector matches all objects.
                              A null label selector matches no objects.
                            properties:
                              matchExpressions:
                                description: matchExpressions is a list of label selector
                                  requirements. The requirements are ANDed.
                                items:
                                  description: A label selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: key is the label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: operator represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists and DoesNotExist.
                                      type: string
                                    values:
                                      description: values is an array of string values.
                                        If the operator is In or NotIn, the values
                                        array must be non-empty. If the operator is
                                        Exists or DoesNotExist, the values array must
                                        be empty. This array is replaced during a
                                        strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchLabels:
                                description: matchLabels is a map of {key,value} pairs.
                                  A single {key,value} in the matchLabels map is equivalent
                                  to an element of matchExpressions, whose key field
                                  is "key", the operator is "In", and the values array
                                  contains only "value". The requirements are ANDed.
                                type: object
                          namespaces:
                            description: namespaces specifies which namespaces the
                              labelSelector applies to (matches against); null or
                              empty list means "this pod's namespace"
                            items:
                              type: string
                            type: array
                          topologyKey:
                            description: This pod should be co-located (affinity)
                              or not co-located (anti-affinity) with the pods matching
                              the labelSelector in the specified namespaces, where
                              co-located is defined as running on a node whose value
                              of the label with key topologyKey matches that of any
                              node on which any of the selected pods is running. Empty
                              topologyKey is not allowed.
                            type: string
                        required:
                        - topologyKey
                      type: array
                podAntiAffinity:
                  description: Pod anti affinity is a group of inter pod anti affinity
                    scheduling rules.
                  properties:
                    preferredDuringSchedulingIgnoredDuringExecution:
                      description: The scheduler will prefer to schedule pods to nodes
                        that satisfy the anti-affinity expressions specified by this
                        field, but it may choose a node that violates one or more
                        of the expressions. The node that is most preferred is the
                        one with the greatest sum of weights, i.e. for each node that
                        meets all of the scheduling requirements (resource request,
                        requiredDuringScheduling anti-affinity expressions, etc.),
                        compute a sum by iterating through the elements of this field
                        and adding "weight" to the sum if the node has pods which
                        matches the corresponding podAffinityTerm; the node(s) with
                        the highest sum are the most preferred.
                      items:
                        description: The weights of all of the matched WeightedPodAffinityTerm
                          fields are added per-node to find the most preferred node(s)
                        properties:
                          podAffinityTerm:
                            description: Defines a set of pods (namely those matching
                              the labelSelector relative to the given namespace(s))
                              that this pod should be co-located (affinity) or not
                              co-located (anti-affinity) with, where co-located is
                              defined as running on a node whose value of the label
                              with key <topologyKey> matches that of any node on which
                              a pod of the set of pods is running
                            properties:
                              labelSelector:
                                description: A label selector is a label query over
                                  a set of resources. The result of matchLabels and
                                  matchExpressions are ANDed. An empty label selector
                                  matches all objects. A null label selector matches
                                  no objects.
                                properties:
                                  matchExpressions:
                                    description: matchExpressions is a list of label
                                      selector requirements. The requirements are
                                      ANDed.
                                    items:
                                      description: A label selector requirement is
                                        a selector that contains values, a key, and
                                        an operator that relates the key and values.
                                      properties:
                                        key:
                                          description: key is the label key that the
                                            selector applies to.
                                          type: string
                                        operator:
                                          description: operator represents a key's
                                            relationship to a set of values. Valid
                                            operators are In, NotIn, Exists and DoesNotExist.
                                          type: string
                                        values:
                                          description: values is an array of string
                                            values. If the operator is In or NotIn,
                                            the values array must be non-empty. If
                                            the operator is Exists or DoesNotExist,
                                            the values array must be empty. This array
                                            is replaced during a strategic merge patch.
                                          items:
                                            type: string
                                          type: array
                                      required:
                                      - key
                                      - operator
                                    type: array
                                  matchLabels:
                                    description: matchLabels is a map of {key,value}
                                      pairs. A single {key,value} in the matchLabels
                                      map is equivalent to an element of matchExpressions,
                                      whose key field is "key", the operator is "In",
                                      and the values array contains only "value".
                                      The requirements are ANDed.
                                    type: object
                              namespaces:
                                description: namespaces specifies which namespaces
                                  the labelSelector applies to (matches against);
                                  null or empty list means "this pod's namespace"
                                items:
                                  type: string
                                type: array
                              topologyKey:
                                description: This pod should be co-located (affinity)
                                  or not co-located (anti-affinity) with the pods
                                  matching the labelSelector in the specified namespaces,
                                  where co-located is defined as running on a node
                                  whose value of the label with key topologyKey matches
                                  that of any node on which any of the selected pods
                                  is running. Empty topologyKey is not allowed.
                                type: string
                            required:
                            - topologyKey
                          weight:
                            description: weight associated with matching the corresponding
                              podAffinityTerm, in the range 1-100.
                            format: int32
                            type: integer
                        required:
                        - weight
                        - podAffinityTerm
                      type: array
                    requiredDuringSchedulingIgnoredDuringExecution:
                      description: If the anti-affinity requirements specified by
                        this field are not met at scheduling time, the pod will not
                        be scheduled onto the node. If the anti-affinity requirements
                        specified by this field cease to be met at some point during
                        pod execution (e.g. due to a pod label update), the system
                        may or may not try to eventually evict the pod from its node.
                        When there are multiple elements, the lists of nodes corresponding
                        to each podAffinityTerm are intersected, i.e. all terms must
                        be satisfied.
                      items:
                        description: Defines a set of pods (namely those matching
                          the labelSelector relative to the given namespace(s)) that
                          this pod should be co-located (affinity) or not co-located
                          (anti-affinity) with, where co-located is defined as running
                          on a node whose value of the label with key <topologyKey>
                          matches that of any node on which a pod of the set of pods
                          is running
                        properties:
                          labelSelector:
                            description: A label selector is a label query over a
                              set of resources. The result of matchLabels and matchExpressions
                              are ANDed. An empty label selector matches all objects.
                              A null label selector matches no objects.
                            properties:
                              matchExpressions:
                                description: matchExpressions is a list of label selector
                                  requirements. The requirements are ANDed.
                                items:
                                  description: A label selector requirement is a selector
                                    that contains values, a key, and an operator that
                                    relates the key and values.
                                  properties:
                                    key:
                                      description: key is the label key that the selector
                                        applies to.
                                      type: string
                                    operator:
                                      description: operator represents a key's relationship
                                        to a set of values. Valid operators are In,
                                        NotIn, Exists and DoesNotExist.
                                      type: string
                                    values:
                                      description: values is an array of string values.
                                        If the operator is In or NotIn, the values
                                        array must be non-empty. If the operator is
                                        Exists or DoesNotExist, the values array must
                                        be empty. This array is replaced during a
                                        strategic merge patch.
                                      items:
                                        type: string
                                      type: array
                                  required:
                                  - key
                                  - operator
                                type: array
                              matchLabels:
                                description: matchLabels is a map of {key,value} pairs.
                                  A single {key,value} in the matchLabels map is equivalent
                                  to an element of matchExpressions, whose key field
                                  is "key", the operator is "In", and the values array
                                  contains only "value". The requirements are ANDed.
                                type: object
                          namespaces:
                            description: namespaces specifies which namespaces the
                              labelSelector applies to (matches against); null or
                              empty list means "this pod's namespace"
                            items:
                              type: string
                            type: array
                          topologyKey:
                            description: This pod should be co-located (affinity)
                              or not co-located (anti-affinity) with the pods matching
                              the labelSelector in the specified namespaces, where
                              co-located is defined as running on a node whose value
                              of the label with key topologyKey matches that of any
                              node on which any of the selected pods is running. Empty
                              topologyKey is not allowed.
                            type: string
                        required:
                        - topologyKey
                      type: array
            alerting:
              description: AlertingSpec defines parameters for alerting configuration
                of Prometheus servers.
              properties:
                alertmanagers:
                  description: AlertmanagerEndpoints Prometheus should fire alerts
                    against.
                  items:
                    description: AlertmanagerEndpoints defines a selection of a single
                      Endpoints object containing alertmanager IPs to fire alerts
                      against.
                    properties:
                      bearerTokenFile:
                        description: BearerTokenFile to read from filesystem to use
                          when authenticating to Alertmanager.
                        type: string
                      name:
                        description: Name of Endpoints object in Namespace.
                        type: string
                      namespace:
                        description: Namespace of Endpoints object.
                        type: string
                      pathPrefix:
                        description: Prefix for the HTTP path alerts are pushed to.
                        type: string
                      port:
                        anyOf:
                        - type: string
                        - type: integer
                      scheme:
                        description: Scheme to use when firing alerts.
                        type: string
                      tlsConfig:
                        description: TLSConfig specifies TLS configuration parameters.
                        properties:
                          caFile:
                            description: The CA cert to use for the targets.
                            type: string
                          certFile:
                            description: The client cert file for the targets.
                            type: string
                          insecureSkipVerify:
                            description: Disable target certificate validation.
                            type: boolean
                          keyFile:
                            description: The client key file for the targets.
                            type: string
                          serverName:
                            description: Used to verify the hostname for the targets.
                            type: string
                    required:
                    - namespace
                    - name
                    - port
                  type: array
              required:
              - alertmanagers
            apiserverConfig:
              description: 'APIServerConfig defines a host and auth methods to access
                apiserver. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#kubernetes_sd_config'
              properties:
                basicAuth:
                  description: 'BasicAuth allow an endpoint to authenticate over basic
                    authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints'
                  properties:
                    password:
                      description: SecretKeySelector selects a key of a Secret.
                      properties:
                        key:
                          description: The key of the secret to select from.  Must
                            be a valid secret key.
                          type: string
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                          type: string
                        optional:
                          description: Specify whether the Secret or it's key must
                            be defined
                          type: boolean
                      required:
                      - key
                    username:
                      description: SecretKeySelector selects a key of a Secret.
                      properties:
                        key:
                          description: The key of the secret to select from.  Must
                            be a valid secret key.
                          type: string
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                          type: string
                        optional:
                          description: Specify whether the Secret or it's key must
                            be defined
                          type: boolean
                      required:
                      - key
                bearerToken:
                  description: Bearer token for accessing apiserver.
                  type: string
                bearerTokenFile:
                  description: File to read bearer token for accessing apiserver.
                  type: string
                host:
                  description: Host of apiserver. A valid string consisting of a hostname
                    or IP followed by an optional port number
                  type: string
                tlsConfig:
                  description: TLSConfig specifies TLS configuration parameters.
                  properties:
                    caFile:
                      description: The CA cert to use for the targets.
                      type: string
                    certFile:
                      description: The client cert file for the targets.
                      type: string
                    insecureSkipVerify:
                      description: Disable target certificate validation.
                      type: boolean
                    keyFile:
                      description: The client key file for the targets.
                      type: string
                    serverName:
                      description: Used to verify the hostname for the targets.
                      type: string
              required:
              - host
            baseImage:
              description: Base image to use for a Prometheus deployment.
              type: string
            configMaps:
              description: ConfigMaps is a list of ConfigMaps in the same namespace
                as the Prometheus object, which shall be mounted into the Prometheus
                Pods. The ConfigMaps are mounted into /etc/prometheus/configmaps/<configmap-name>.
              items:
                type: string
              type: array
            containers:
              description: Containers allows injecting additional containers. This
                is meant to allow adding an authentication proxy to a Prometheus pod.
              items:
                description: A single application container that you want to run within
                  a pod.
                properties:
                  args:
                    description: 'Arguments to the entrypoint. The docker image''s
                      CMD is used if this is not provided. Variable references $(VAR_NAME)
                      are expanded using the container''s environment. If a variable
                      cannot be resolved, the reference in the input string will be
                      unchanged. The $(VAR_NAME) syntax can be escaped with a double
                      $$, ie: $$(VAR_NAME). Escaped references will never be expanded,
                      regardless of whether the variable exists or not. Cannot be
                      updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                    items:
                      type: string
                    type: array
                  command:
                    description: 'Entrypoint array. Not executed within a shell. The
                      docker image''s ENTRYPOINT is used if this is not provided.
                      Variable references $(VAR_NAME) are expanded using the container''s
                      environment. If a variable cannot be resolved, the reference
                      in the input string will be unchanged. The $(VAR_NAME) syntax
                      can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references
                      will never be expanded, regardless of whether the variable exists
                      or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell'
                    items:
                      type: string
                    type: array
                  env:
                    description: List of environment variables to set in the container.
                      Cannot be updated.
                    items:
                      description: EnvVar represents an environment variable present
                        in a Container.
                      properties:
                        name:
                          description: Name of the environment variable. Must be a
                            C_IDENTIFIER.
                          type: string
                        value:
                          description: 'Variable references $(VAR_NAME) are expanded
                            using the previous defined environment variables in the
                            container and any service environment variables. If a
                            variable cannot be resolved, the reference in the input
                            string will be unchanged. The $(VAR_NAME) syntax can be
                            escaped with a double $$, ie: $$(VAR_NAME). Escaped references
                            will never be expanded, regardless of whether the variable
                            exists or not. Defaults to "".'
                          type: string
                        valueFrom:
                          description: EnvVarSource represents a source for the value
                            of an EnvVar.
                          properties:
                            configMapKeyRef:
                              description: Selects a key from a ConfigMap.
                              properties:
                                key:
                                  description: The key to select.
                                  type: string
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                                  type: string
                                optional:
                                  description: Specify whether the ConfigMap or it's
                                    key must be defined
                                  type: boolean
                              required:
                              - key
                            fieldRef:
                              description: ObjectFieldSelector selects an APIVersioned
                                field of an object.
                              properties:
                                apiVersion:
                                  description: Version of the schema the FieldPath
                                    is written in terms of, defaults to "v1".
                                  type: string
                                fieldPath:
                                  description: Path of the field to select in the
                                    specified API version.
                                  type: string
                              required:
                              - fieldPath
                            resourceFieldRef:
                              description: ResourceFieldSelector represents container
                                resources (cpu, memory) and their output format
                              properties:
                                containerName:
                                  description: 'Container name: required for volumes,
                                    optional for env vars'
                                  type: string
                                divisor: {}
                                resource:
                                  description: 'Required: resource to select'
                                  type: string
                              required:
                              - resource
                            secretKeyRef:
                              description: SecretKeySelector selects a key of a Secret.
                              properties:
                                key:
                                  description: The key of the secret to select from.  Must
                                    be a valid secret key.
                                  type: string
                                name:
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                                  type: string
                                optional:
                                  description: Specify whether the Secret or it's
                                    key must be defined
                                  type: boolean
                              required:
                              - key
                      required:
                      - name
                    type: array
                  envFrom:
                    description: List of sources to populate environment variables
                      in the container. The keys defined within a source must be a
                      C_IDENTIFIER. All invalid keys will be reported as an event
                      when the container is starting. When a key exists in multiple
                      sources, the value associated with the last source will take
                      precedence. Values defined by an Env with a duplicate key will
                      take precedence. Cannot be updated.
                    items:
                      description: EnvFromSource represents the source of a set of
                        ConfigMaps
                      properties:
                        configMapRef:
                          description: |-
                            ConfigMapEnvSource selects a ConfigMap to populate the environment variables with.

                            The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            optional:
                              description: Specify whether the ConfigMap must be defined
                              type: boolean
                        prefix:
                          description: An optional identifier to prepend to each key
                            in the ConfigMap. Must be a C_IDENTIFIER.
                          type: string
                        secretRef:
                          description: |-
                            SecretEnvSource selects a Secret to populate the environment variables with.

                            The contents of the target Secret's Data field will represent the key-value pairs as environment variables.
                          properties:
                            name:
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                              type: string
                            optional:
                              description: Specify whether the Secret must be defined
                              type: boolean
                    type: array
                  image:
                    description: 'Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images
                      This field is optional to allow higher level config management
                      to default or override container images in workload controllers
                      like Deployments and StatefulSets.'
                    type: string
                  imagePullPolicy:
                    description: 'Image pull policy. One of Always, Never, IfNotPresent.
                      Defaults to Always if :latest tag is specified, or IfNotPresent
                      otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images'
                    type: string
                  lifecycle:
                    description: Lifecycle describes actions that the management system
                      should take in response to container lifecycle events. For the
                      PostStart and PreStop lifecycle handlers, management of the
                      container blocks until the action is complete, unless the container
                      process fails, in which case the handler is aborted.
                    properties:
                      postStart:
                        description: Handler defines a specific action that should
                          be taken
                        properties:
                          exec:
                            description: ExecAction describes a "run in container"
                              action.
                            properties:
                              command:
                                description: Command is the command line to execute
                                  inside the container, the working directory for
                                  the command  is root ('/') in the container's filesystem.
                                  The command is simply exec'd, it is not run inside
                                  a shell, so traditional shell instructions ('|',
                                  etc) won't work. To use a shell, you need to explicitly
                                  call out to that shell. Exit status of 0 is treated
                                  as live/healthy and non-zero is unhealthy.
                                items:
                                  type: string
                                type: array
                          httpGet:
                            description: HTTPGetAction describes an action based on
                              HTTP Get requests.
                            properties:
                              host:
                                description: Host name to connect to, defaults to
                                  the pod IP. You probably want to set "Host" in httpHeaders
                                  instead.
                                type: string
                              httpHeaders:
                                description: Custom headers to set in the request.
                                  HTTP allows repeated headers.
                                items:
                                  description: HTTPHeader describes a custom header
                                    to be used in HTTP probes
                                  properties:
                                    name:
                                      description: The header field name
                                      type: string
                                    value:
                                      description: The header field value
                                      type: string
                                  required:
                                  - name
                                  - value
                                type: array
                              path:
                                description: Path to access on the HTTP server.
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                              scheme:
                                description: Scheme to use for connecting to the host.
                                  Defaults to HTTP.
                                type: string
                            required:
                            - port
                          tcpSocket:
                            description: TCPSocketAction describes an action based
                              on opening a socket
                            properties:
                              host:
                                description: 'Optional: Host name to connect to, defaults
                                  to the pod IP.'
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                            required:
                            - port
                      preStop:
                        description: Handler defines a specific action that should
                          be taken
                        properties:
                          exec:
                            description: ExecAction describes a "run in container"
                              action.
                            properties:
                              command:
                                description: Command is the command line to execute
                                  inside the container, the working directory for
                                  the command  is root ('/') in the container's filesystem.
                                  The command is simply exec'd, it is not run inside
                                  a shell, so traditional shell instructions ('|',
                                  etc) won't work. To use a shell, you need to explicitly
                                  call out to that shell. Exit status of 0 is treated
                                  as live/healthy and non-zero is unhealthy.
                                items:
                                  type: string
                                type: array
                          httpGet:
                            description: HTTPGetAction describes an action based on
                              HTTP Get requests.
                            properties:
                              host:
                                description: Host name to connect to, defaults to
                                  the pod IP. You probably want to set "Host" in httpHeaders
                                  instead.
                                type: string
                              httpHeaders:
                                description: Custom headers to set in the request.
                                  HTTP allows repeated headers.
                                items:
                                  description: HTTPHeader describes a custom header
                                    to be used in HTTP probes
                                  properties:
                                    name:
                                      description: The header field name
                                      type: string
                                    value:
                                      description: The header field value
                                      type: string
                                  required:
                                  - name
                                  - value
                                type: array
                              path:
                                description: Path to access on the HTTP server.
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                              scheme:
                                description: Scheme to use for connecting to the host.
                                  Defaults to HTTP.
                                type: string
                            required:
                            - port
                          tcpSocket:
                            description: TCPSocketAction describes an action based
                              on opening a socket
                            properties:
                              host:
                                description: 'Optional: Host name to connect to, defaults
                                  to the pod IP.'
                                type: string
                              port:
                                anyOf:
                                - type: string
                                - type: integer
                            required:
                            - port
                  livenessProbe:
                    description: Probe describes a health check to be performed against
                      a container to determine whether it is alive or ready to receive
                      traffic.
                    properties:
                      exec:
                        description: ExecAction describes a "run in container" action.
                        properties:
                          command:
                            description: Command is the command line to execute inside
                              the container, the working directory for the command  is
                              root ('/') in the container's filesystem. The command
                              is simply exec'd, it is not run inside a shell, so traditional
                              shell instructions ('|', etc) won't work. To use a shell,
                              you need to explicitly call out to that shell. Exit
                              status of 0 is treated as live/healthy and non-zero
                              is unhealthy.
                            items:
                              type: string
                            type: array
                      failureThreshold:
                        description: Minimum consecutive failures for the probe to
                          be considered failed after having succeeded. Defaults to
                          3. Minimum value is 1.
                        format: int32
                        type: integer
                      httpGet:
                        description: HTTPGetAction describes an action based on HTTP
                          Get requests.
                        properties:
                          host:
                            description: Host name to connect to, defaults to the
                              pod IP. You probably want to set "Host" in httpHeaders
                              instead.
                            type: string
                          httpHeaders:
                            description: Custom headers to set in the request. HTTP
                              allows repeated headers.
                            items:
                              description: HTTPHeader describes a custom header to
                                be used in HTTP probes
                              properties:
                                name:
                                  description: The header field name
                                  type: string
                                value:
                                  description: The header field value
                                  type: string
                              required:
                              - name
                              - value
                            type: array
                          path:
                            description: Path to access on the HTTP server.
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                          scheme:
                            description: Scheme to use for connecting to the host.
                              Defaults to HTTP.
                            type: string
                        required:
                        - port
                      initialDelaySeconds:
                        description: 'Number of seconds after the container has started
                          before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                      periodSeconds:
                        description: How often (in seconds) to perform the probe.
                          Default to 10 seconds. Minimum value is 1.
                        format: int32
                        type: integer
                      successThreshold:
                        description: Minimum consecutive successes for the probe to
                          be considered successful after having failed. Defaults to
                          1. Must be 1 for liveness. Minimum value is 1.
                        format: int32
                        type: integer
                      tcpSocket:
                        description: TCPSocketAction describes an action based on
                          opening a socket
                        properties:
                          host:
                            description: 'Optional: Host name to connect to, defaults
                              to the pod IP.'
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                        required:
                        - port
                      timeoutSeconds:
                        description: 'Number of seconds after which the probe times
                          out. Defaults to 1 second. Minimum value is 1. More info:
                          https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                  name:
                    description: Name of the container specified as a DNS_LABEL. Each
                      container in a pod must have a unique name (DNS_LABEL). Cannot
                      be updated.
                    type: string
                  ports:
                    description: List of ports to expose from the container. Exposing
                      a port here gives the system additional information about the
                      network connections a container uses, but is primarily informational.
                      Not specifying a port here DOES NOT prevent that port from being
                      exposed. Any port which is listening on the default "0.0.0.0"
                      address inside a container will be accessible from the network.
                      Cannot be updated.
                    items:
                      description: ContainerPort represents a network port in a single
                        container.
                      properties:
                        containerPort:
                          description: Number of port to expose on the pod's IP address.
                            This must be a valid port number, 0 < x < 65536.
                          format: int32
                          type: integer
                        hostIP:
                          description: What host IP to bind the external port to.
                          type: string
                        hostPort:
                          description: Number of port to expose on the host. If specified,
                            this must be a valid port number, 0 < x < 65536. If HostNetwork
                            is specified, this must match ContainerPort. Most containers
                            do not need this.
                          format: int32
                          type: integer
                        name:
                          description: If specified, this must be an IANA_SVC_NAME
                            and unique within the pod. Each named port in a pod must
                            have a unique name. Name for the port that can be referred
                            to by services.
                          type: string
                        protocol:
                          description: Protocol for port. Must be UDP, TCP, or SCTP.
                            Defaults to "TCP".
                          type: string
                      required:
                      - containerPort
                    type: array
                  readinessProbe:
                    description: Probe describes a health check to be performed against
                      a container to determine whether it is alive or ready to receive
                      traffic.
                    properties:
                      exec:
                        description: ExecAction describes a "run in container" action.
                        properties:
                          command:
                            description: Command is the command line to execute inside
                              the container, the working directory for the command  is
                              root ('/') in the container's filesystem. The command
                              is simply exec'd, it is not run inside a shell, so traditional
                              shell instructions ('|', etc) won't work. To use a shell,
                              you need to explicitly call out to that shell. Exit
                              status of 0 is treated as live/healthy and non-zero
                              is unhealthy.
                            items:
                              type: string
                            type: array
                      failureThreshold:
                        description: Minimum consecutive failures for the probe to
                          be considered failed after having succeeded. Defaults to
                          3. Minimum value is 1.
                        format: int32
                        type: integer
                      httpGet:
                        description: HTTPGetAction describes an action based on HTTP
                          Get requests.
                        properties:
                          host:
                            description: Host name to connect to, defaults to the
                              pod IP. You probably want to set "Host" in httpHeaders
                              instead.
                            type: string
                          httpHeaders:
                            description: Custom headers to set in the request. HTTP
                              allows repeated headers.
                            items:
                              description: HTTPHeader describes a custom header to
                                be used in HTTP probes
                              properties:
                                name:
                                  description: The header field name
                                  type: string
                                value:
                                  description: The header field value
                                  type: string
                              required:
                              - name
                              - value
                            type: array
                          path:
                            description: Path to access on the HTTP server.
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                          scheme:
                            description: Scheme to use for connecting to the host.
                              Defaults to HTTP.
                            type: string
                        required:
                        - port
                      initialDelaySeconds:
                        description: 'Number of seconds after the container has started
                          before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                      periodSeconds:
                        description: How often (in seconds) to perform the probe.
                          Default to 10 seconds. Minimum value is 1.
                        format: int32
                        type: integer
                      successThreshold:
                        description: Minimum consecutive successes for the probe to
                          be considered successful after having failed. Defaults to
                          1. Must be 1 for liveness. Minimum value is 1.
                        format: int32
                        type: integer
                      tcpSocket:
                        description: TCPSocketAction describes an action based on
                          opening a socket
                        properties:
                          host:
                            description: 'Optional: Host name to connect to, defaults
                              to the pod IP.'
                            type: string
                          port:
                            anyOf:
                            - type: string
                            - type: integer
                        required:
                        - port
                      timeoutSeconds:
                        description: 'Number of seconds after which the probe times
                          out. Defaults to 1 second. Minimum value is 1. More info:
                          https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes'
                        format: int32
                        type: integer
                  resources:
                    description: ResourceRequirements describes the compute resource
                      requirements.
                    properties:
                      limits:
                        description: 'Limits describes the maximum amount of compute
                          resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                        type: object
                      requests:
                        description: 'Requests describes the minimum amount of compute
                          resources required. If Requests is omitted for a container,
                          it defaults to Limits if that is explicitly specified, otherwise
                          to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                        type: object
                  securityContext:
                    description: SecurityContext holds security configuration that
                      will be applied to a container. Some fields are present in both
                      SecurityContext and PodSecurityContext.  When both are set,
                      the values in SecurityContext take precedence.
                    properties:
                      allowPrivilegeEscalation:
                        description: 'AllowPrivilegeEscalation controls whether a
                          process can gain more privileges than its parent process.
                          This bool directly controls if the no_new_privs flag will
                          be set on the container process. AllowPrivilegeEscalation
                          is true always when the container is: 1) run as Privileged
                          2) has CAP_SYS_ADMIN'
                        type: boolean
                      capabilities:
                        description: Adds and removes POSIX capabilities from running
                          containers.
                        properties:
                          add:
                            description: Added capabilities
                            items:
                              type: string
                            type: array
                          drop:
                            description: Removed capabilities
                            items:
                              type: string
                            type: array
                      privileged:
                        description: Run container in privileged mode. Processes in
                          privileged containers are essentially equivalent to root
                          on the host. Defaults to false.
                        type: boolean
                      procMount:
                        description: procMount denotes the type of proc mount to use
                          for the containers. The default is DefaultProcMount which
                          uses the container runtime defaults for readonly paths and
                          masked paths. This requires the ProcMountType feature flag
                          to be enabled.
                        type: string
                      readOnlyRootFilesystem:
                        description: Whether this container has a read-only root filesystem.
                          Default is false.
                        type: boolean
                      runAsGroup:
                        description: The GID to run the entrypoint of the container
                          process. Uses runtime default if unset. May also be set
                          in PodSecurityContext.  If set in both SecurityContext and
                          PodSecurityContext, the value specified in SecurityContext
                          takes precedence.
                        format: int64
                        type: integer
                      runAsNonRoot:
                        description: Indicates that the container must run as a non-root
                          user. If true, the Kubelet will validate the image at runtime
                          to ensure that it does not run as UID 0 (root) and fail
                          to start the container if it does. If unset or false, no
                          such validation will be performed. May also be set in PodSecurityContext.  If
                          set in both SecurityContext and PodSecurityContext, the
                          value specified in SecurityContext takes precedence.
                        type: boolean
                      runAsUser:
                        description: The UID to run the entrypoint of the container
                          process. Defaults to user specified in image metadata if
                          unspecified. May also be set in PodSecurityContext.  If
                          set in both SecurityContext and PodSecurityContext, the
                          value specified in SecurityContext takes precedence.
                        format: int64
                        type: integer
                      seLinuxOptions:
                        description: SELinuxOptions are the labels to be applied to
                          the container
                        properties:
                          level:
                            description: Level is SELinux level label that applies
                              to the container.
                            type: string
                          role:
                            description: Role is a SELinux role label that applies
                              to the container.
                            type: string
                          type:
                            description: Type is a SELinux type label that applies
                              to the container.
                            type: string
                          user:
                            description: User is a SELinux user label that applies
                              to the container.
                            type: string
                  stdin:
                    description: Whether this container should allocate a buffer for
                      stdin in the container runtime. If this is not set, reads from
                      stdin in the container will always result in EOF. Default is
                      false.
                    type: boolean
                  stdinOnce:
                    description: Whether the container runtime should close the stdin
                      channel after it has been opened by a single attach. When stdin
                      is true the stdin stream will remain open across multiple attach
                      sessions. If stdinOnce is set to true, stdin is opened on container
                      start, is empty until the first client attaches to stdin, and
                      then remains open and accepts data until the client disconnects,
                      at which time stdin is closed and remains closed until the container
                      is restarted. If this flag is false, a container processes that
                      reads from stdin will never receive an EOF. Default is false
                    type: boolean
                  terminationMessagePath:
                    description: 'Optional: Path at which the file to which the container''s
                      termination message will be written is mounted into the container''s
                      filesystem. Message written is intended to be brief final status,
                      such as an assertion failure message. Will be truncated by the
                      node if greater than 4096 bytes. The total message length across
                      all containers will be limited to 12kb. Defaults to /dev/termination-log.
                      Cannot be updated.'
                    type: string
                  terminationMessagePolicy:
                    description: Indicate how the termination message should be populated.
                      File will use the contents of terminationMessagePath to populate
                      the container status message on both success and failure. FallbackToLogsOnError
                      will use the last chunk of container log output if the termination
                      message file is empty and the container exited with an error.
                      The log output is limited to 2048 bytes or 80 lines, whichever
                      is smaller. Defaults to File. Cannot be updated.
                    type: string
                  tty:
                    description: Whether this container should allocate a TTY for
                      itself, also requires 'stdin' to be true. Default is false.
                    type: boolean
                  volumeDevices:
                    description: volumeDevices is the list of block devices to be
                      used by the container. This is an alpha feature and may change
                      in the future.
                    items:
                      description: volumeDevice describes a mapping of a raw block
                        device within a container.
                      properties:
                        devicePath:
                          description: devicePath is the path inside of the container
                            that the device will be mapped to.
                          type: string
                        name:
                          description: name must match the name of a persistentVolumeClaim
                            in the pod
                          type: string
                      required:
                      - name
                      - devicePath
                    type: array
                  volumeMounts:
                    description: Pod volumes to mount into the container's filesystem.
                      Cannot be updated.
                    items:
                      description: VolumeMount describes a mounting of a Volume within
                        a container.
                      properties:
                        mountPath:
                          description: Path within the container at which the volume
                            should be mounted.  Must not contain ':'.
                          type: string
                        mountPropagation:
                          description: mountPropagation determines how mounts are
                            propagated from the host to container and the other way
                            around. When not set, MountPropagationNone is used. This
                            field is beta in 1.10.
                          type: string
                        name:
                          description: This must match the Name of a Volume.
                          type: string
                        readOnly:
                          description: Mounted read-only if true, read-write otherwise
                            (false or unspecified). Defaults to false.
                          type: boolean
                        subPath:
                          description: Path within the volume from which the container's
                            volume should be mounted. Defaults to "" (volume's root).
                          type: string
                      required:
                      - name
                      - mountPath
                    type: array
                  workingDir:
                    description: Container's working directory. If not specified,
                      the container runtime's default will be used, which might be
                      configured in the container image. Cannot be updated.
                    type: string
                required:
                - name
              type: array
            enableAdminAPI:
              description: 'Enable access to prometheus web admin API. Defaults to
                the value of `false`. WARNING: Enabling the admin APIs enables mutating
                endpoints, to delete data, shutdown Prometheus, and more. Enabling
                this should be done with care and the user is advised to add additional
                authentication authorization via a proxy to ensure only clients authorized
                to perform these actions can do so. For more information see https://prometheus.io/docs/prometheus/latest/querying/api/#tsdb-admin-apis'
              type: boolean
            evaluationInterval:
              description: Interval between consecutive evaluations.
              type: string
            externalLabels:
              description: The labels to add to any time series or alerts when communicating
                with external systems (federation, remote storage, Alertmanager).
              type: object
            externalUrl:
              description: The external URL the Prometheus instances will be available
                under. This is necessary to generate correct URLs. This is necessary
                if Prometheus is not served from root of a DNS name.
              type: string
            image:
              description: Image if specified has precedence over baseImage, tag and
                sha combinations. Specifying the version is still necessary to ensure
                the Prometheus Operator knows what version of Prometheus is being
                configured.
              type: string
            imagePullSecrets:
              description: An optional list of references to secrets in the same namespace
                to use for pulling prometheus and alertmanager images from registries
                see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod
              items:
                description: LocalObjectReference contains enough information to let
                  you locate the referenced object inside the same namespace.
                properties:
                  name:
                    description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                    type: string
              type: array
            listenLocal:
              description: ListenLocal makes the Prometheus server listen on loopback,
                so that it does not bind against the Pod IP.
              type: boolean
            logFormat:
              description: Log format for Prometheus to be configured with.
              type: string
            logLevel:
              description: Log level for Prometheus to be configured with.
              type: string
            nodeSelector:
              description: Define which Nodes the Pods are scheduled on.
              type: object
            paused:
              description: When a Prometheus deployment is paused, no actions except
                for deletion will be performed on the underlying objects.
              type: boolean
            podMetadata:
              description: ObjectMeta is metadata that all persisted resources must
                have, which includes all objects users must create.
              properties:
                annotations:
                  description: 'Annotations is an unstructured key value map stored
                    with a resource that may be set by external tools to store and
                    retrieve arbitrary metadata. They are not queryable and should
                    be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations'
                  type: object
                clusterName:
                  description: The name of the cluster which the object belongs to.
                    This is used to distinguish resources with same name and namespace
                    in different clusters. This field is not set anywhere right now
                    and apiserver is going to ignore it if set in create or update
                    request.
                  type: string
                creationTimestamp:
                  description: Time is a wrapper around time.Time which supports correct
                    marshaling to YAML and JSON.  Wrappers are provided for many of
                    the factory methods that the time package offers.
                  format: date-time
                  type: string
                deletionGracePeriodSeconds:
                  description: Number of seconds allowed for this object to gracefully
                    terminate before it will be removed from the system. Only set
                    when deletionTimestamp is also set. May only be shortened. Read-only.
                  format: int64
                  type: integer
                deletionTimestamp:
                  description: Time is a wrapper around time.Time which supports correct
                    marshaling to YAML and JSON.  Wrappers are provided for many of
                    the factory methods that the time package offers.
                  format: date-time
                  type: string
                finalizers:
                  description: Must be empty before the object is deleted from the
                    registry. Each entry is an identifier for the responsible component
                    that will remove the entry from the list. If the deletionTimestamp
                    of the object is non-nil, entries in this list can only be removed.
                  items:
                    type: string
                  type: array
                generateName:
                  description: |-
                    GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.

                    If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).

                    Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
                  type: string
                generation:
                  description: A sequence number representing a specific generation
                    of the desired state. Populated by the system. Read-only.
                  format: int64
                  type: integer
                initializers:
                  description: Initializers tracks the progress of initialization.
                  properties:
                    pending:
                      description: Pending is a list of initializers that must execute
                        in order before this object is visible. When the last pending
                        initializer is removed, and no failing result is set, the
                        initializers struct will be set to nil and the object is considered
                        as initialized and visible to all clients.
                      items:
                        description: Initializer is information about an initializer
                          that has not yet completed.
                        properties:
                          name:
                            description: name of the process that is responsible for
                              initializing this object.
                            type: string
                        required:
                        - name
                      type: array
                    result:
                      description: Status is a return value for calls that don't return
                        other objects.
                      properties:
                        apiVersion:
                          description: 'APIVersion defines the versioned schema of
                            this representation of an object. Servers should convert
                            recognized schemas to the latest internal value, and may
                            reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                          type: string
                        code:
                          description: Suggested HTTP return code for this status,
                            0 if not set.
                          format: int32
                          type: integer
                        details:
                          description: StatusDetails is a set of additional properties
                            that MAY be set by the server to provide additional information
                            about a response. The Reason field of a Status object
                            defines what attributes will be set. Clients must ignore
                            fields that do not match the defined type of each attribute,
                            and should assume that any attribute may be empty, invalid,
                            or under defined.
                          properties:
                            causes:
                              description: The Causes array includes more details
                                associated with the StatusReason failure. Not all
                                StatusReasons may provide detailed causes.
                              items:
                                description: StatusCause provides more information
                                  about an api.Status failure, including cases when
                                  multiple errors are encountered.
                                properties:
                                  field:
                                    description: |-
                                      The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

                                      Examples:
                                        "name" - the field "name" on the current resource
                                        "items[0].name" - the field "name" on the first array entry in "items"
                                    type: string
                                  message:
                                    description: A human-readable description of the
                                      cause of the error.  This field may be presented
                                      as-is to a reader.
                                    type: string
                                  reason:
                                    description: A machine-readable description of
                                      the cause of the error. If this value is empty
                                      there is no information available.
                                    type: string
                              type: array
                            group:
                              description: The group attribute of the resource associated
                                with the status StatusReason.
                              type: string
                            kind:
                              description: 'The kind attribute of the resource associated
                                with the status StatusReason. On some operations may
                                differ from the requested resource Kind. More info:
                                https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                              type: string
                            name:
                              description: The name attribute of the resource associated
                                with the status StatusReason (when there is a single
                                name which can be described).
                              type: string
                            retryAfterSeconds:
                              description: If specified, the time in seconds before
                                the operation should be retried. Some errors may indicate
                                the client must take an alternate action - for those
                                errors this field may indicate how long to wait before
                                taking the alternate action.
                              format: int32
                              type: integer
                            uid:
                              description: 'UID of the resource. (when there is a
                                single resource which can be described). More info:
                                http://kubernetes.io/docs/user-guide/identifiers#uids'
                              type: string
                        kind:
                          description: 'Kind is a string value representing the REST
                            resource this object represents. Servers may infer this
                            from the endpoint the client submits requests to. Cannot
                            be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                          type: string
                        message:
                          description: A human-readable description of the status
                            of this operation.
                          type: string
                        metadata:
                          description: ListMeta describes metadata that synthetic
                            resources must have, including lists and various status
                            objects. A resource may have only one of {ObjectMeta,
                            ListMeta}.
                          properties:
                            continue:
                              description: continue may be set if the user set a limit
                                on the number of items returned, and indicates that
                                the server has more data available. The value is opaque
                                and may be used to issue another request to the endpoint
                                that served this list to retrieve the next set of
                                available objects. Continuing a consistent list may
                                not be possible if the server configuration has changed
                                or more than a few minutes have passed. The resourceVersion
                                field returned when using this continue value will
                                be identical to the value in the first response, unless
                                you have received this token from an error message.
                              type: string
                            resourceVersion:
                              description: 'String that identifies the server''s internal
                                version of this object that can be used by clients
                                to determine when objects have changed. Value must
                                be treated as opaque by clients and passed unmodified
                                back to the server. Populated by the system. Read-only.
                                More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency'
                              type: string
                            selfLink:
                              description: selfLink is a URL representing this object.
                                Populated by the system. Read-only.
                              type: string
                        reason:
                          description: A machine-readable description of why this
                            operation is in the "Failure" status. If this value is
                            empty there is no information available. A Reason clarifies
                            an HTTP status code but does not override it.
                          type: string
                        status:
                          description: 'Status of the operation. One of: "Success"
                            or "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status'
                          type: string
                  required:
                  - pending
                labels:
                  description: 'Map of string keys and values that can be used to
                    organize and categorize (scope and select) objects. May match
                    selectors of replication controllers and services. More info:
                    http://kubernetes.io/docs/user-guide/labels'
                  type: object
                name:
                  description: 'Name must be unique within a namespace. Is required
                    when creating resources, although some resources may allow a client
                    to request the generation of an appropriate name automatically.
                    Name is primarily intended for creation idempotence and configuration
                    definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                  type: string
                namespace:
                  description: |-
                    Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.

                    Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
                  type: string
                ownerReferences:
                  description: List of objects depended by this object. If ALL objects
                    in the list have been deleted, this object will be garbage collected.
                    If this object is managed by a controller, then an entry in this
                    list will point to this controller, with the controller field
                    set to true. There cannot be more than one managing controller.
                  items:
                    description: OwnerReference contains enough information to let
                      you identify an owning object. Currently, an owning object must
                      be in the same namespace, so there is no namespace field.
                    properties:
                      apiVersion:
                        description: API version of the referent.
                        type: string
                      blockOwnerDeletion:
                        description: If true, AND if the owner has the "foregroundDeletion"
                          finalizer, then the owner cannot be deleted from the key-value
                          store until this reference is removed. Defaults to false.
                          To set this field, a user needs "delete" permission of the
                          owner, otherwise 422 (Unprocessable Entity) will be returned.
                        type: boolean
                      controller:
                        description: If true, this reference points to the managing
                          controller.
                        type: boolean
                      kind:
                        description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                        type: string
                      name:
                        description: 'Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                        type: string
                      uid:
                        description: 'UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                        type: string
                    required:
                    - apiVersion
                    - kind
                    - name
                    - uid
                  type: array
                resourceVersion:
                  description: |-
                    An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.

                    Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
                  type: string
                selfLink:
                  description: SelfLink is a URL representing this object. Populated
                    by the system. Read-only.
                  type: string
                uid:
                  description: |-
                    UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.

                    Populated by the system. Read-only. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
                  type: string
            priorityClassName:
              description: Priority class assigned to the Pods
              type: string
            query:
              description: QuerySpec defines the query command line flags when starting
                Prometheus.
              properties:
                lookbackDelta:
                  description: The delta difference allowed for retrieving metrics
                    during expression evaluations.
                  type: string
                maxConcurrency:
                  description: Number of concurrent queries that can be run at once.
                  format: int32
                  type: integer
                timeout:
                  description: Maximum time a query may take before being aborted.
                  type: string
            remoteRead:
              description: If specified, the remote_read spec. This is an experimental
                feature, it may change in any upcoming release in a breaking way.
              items:
                description: RemoteReadSpec defines the remote_read configuration
                  for prometheus.
                properties:
                  basicAuth:
                    description: 'BasicAuth allow an endpoint to authenticate over
                      basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints'
                    properties:
                      password:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                      username:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                  bearerToken:
                    description: bearer token for remote read.
                    type: string
                  bearerTokenFile:
                    description: File to read bearer token for remote read.
                    type: string
                  proxyUrl:
                    description: Optional ProxyURL
                    type: string
                  readRecent:
                    description: Whether reads should be made for queries for time
                      ranges that the local storage should have complete data for.
                    type: boolean
                  remoteTimeout:
                    description: Timeout for requests to the remote read endpoint.
                    type: string
                  requiredMatchers:
                    description: An optional list of equality matchers which have
                      to be present in a selector to query the remote read endpoint.
                    type: object
                  tlsConfig:
                    description: TLSConfig specifies TLS configuration parameters.
                    properties:
                      caFile:
                        description: The CA cert to use for the targets.
                        type: string
                      certFile:
                        description: The client cert file for the targets.
                        type: string
                      insecureSkipVerify:
                        description: Disable target certificate validation.
                        type: boolean
                      keyFile:
                        description: The client key file for the targets.
                        type: string
                      serverName:
                        description: Used to verify the hostname for the targets.
                        type: string
                  url:
                    description: The URL of the endpoint to send samples to.
                    type: string
                required:
                - url
              type: array
            remoteWrite:
              description: If specified, the remote_write spec. This is an experimental
                feature, it may change in any upcoming release in a breaking way.
              items:
                description: RemoteWriteSpec defines the remote_write configuration
                  for prometheus.
                properties:
                  basicAuth:
                    description: 'BasicAuth allow an endpoint to authenticate over
                      basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints'
                    properties:
                      password:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                      username:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                  bearerToken:
                    description: File to read bearer token for remote write.
                    type: string
                  bearerTokenFile:
                    description: File to read bearer token for remote write.
                    type: string
                  proxyUrl:
                    description: Optional ProxyURL
                    type: string
                  queueConfig:
                    description: QueueConfig allows the tuning of remote_write queue_config
                      parameters. This object is referenced in the RemoteWriteSpec
                      object.
                    properties:
                      batchSendDeadline:
                        description: BatchSendDeadline is the maximum time a sample
                          will wait in buffer.
                        type: string
                      capacity:
                        description: Capacity is the number of samples to buffer per
                          shard before we start dropping them.
                        format: int32
                        type: integer
                      maxBackoff:
                        description: MaxBackoff is the maximum retry delay.
                        type: string
                      maxRetries:
                        description: MaxRetries is the maximum number of times to
                          retry a batch on recoverable errors.
                        format: int32
                        type: integer
                      maxSamplesPerSend:
                        description: MaxSamplesPerSend is the maximum number of samples
                          per send.
                        format: int32
                        type: integer
                      maxShards:
                        description: MaxShards is the maximum number of shards, i.e.
                          amount of concurrency.
                        format: int32
                        type: integer
                      minBackoff:
                        description: MinBackoff is the initial retry delay. Gets doubled
                          for every retry.
                        type: string
                      minShards:
                        description: MinShards is the minimum number of shards, i.e.
                          amount of concurrency.
                        format: int32
                        type: integer
                  remoteTimeout:
                    description: Timeout for requests to the remote write endpoint.
                    type: string
                  tlsConfig:
                    description: TLSConfig specifies TLS configuration parameters.
                    properties:
                      caFile:
                        description: The CA cert to use for the targets.
                        type: string
                      certFile:
                        description: The client cert file for the targets.
                        type: string
                      insecureSkipVerify:
                        description: Disable target certificate validation.
                        type: boolean
                      keyFile:
                        description: The client key file for the targets.
                        type: string
                      serverName:
                        description: Used to verify the hostname for the targets.
                        type: string
                  url:
                    description: The URL of the endpoint to send samples to.
                    type: string
                  writeRelabelConfigs:
                    description: The list of remote write relabel configurations.
                    items:
                      description: 'RelabelConfig allows dynamic rewriting of the
                        label set, being applied to samples before ingestion. It defines
                        `<metric_relabel_configs>`-section of Prometheus configuration.
                        More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs'
                      properties:
                        action:
                          description: Action to perform based on regex matching.
                            Default is 'replace'
                          type: string
                        modulus:
                          description: Modulus to take of the hash of the source label
                            values.
                          format: int64
                          type: integer
                        regex:
                          description: Regular expression against which the extracted
                            value is matched. defailt is '(.*)'
                          type: string
                        replacement:
                          description: Replacement value against which a regex replace
                            is performed if the regular expression matches. Regex
                            capture groups are available. Default is '$1'
                          type: string
                        separator:
                          description: Separator placed between concatenated source
                            label values. default is ';'.
                          type: string
                        sourceLabels:
                          description: The source labels select values from existing
                            labels. Their content is concatenated using the configured
                            separator and matched against the configured regular expression
                            for the replace, keep, and drop actions.
                          items:
                            type: string
                          type: array
                        targetLabel:
                          description: Label to which the resulting value is written
                            in a replace action. It is mandatory for replace actions.
                            Regex capture groups are available.
                          type: string
                    type: array
                required:
                - url
              type: array
            replicas:
              description: Number of instances to deploy for a Prometheus deployment.
              format: int32
              type: integer
            resources:
              description: ResourceRequirements describes the compute resource requirements.
              properties:
                limits:
                  description: 'Limits describes the maximum amount of compute resources
                    allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                  type: object
                requests:
                  description: 'Requests describes the minimum amount of compute resources
                    required. If Requests is omitted for a container, it defaults
                    to Limits if that is explicitly specified, otherwise to an implementation-defined
                    value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                  type: object
            retention:
              description: Time duration Prometheus shall retain data for. Default
                is '24h', and must match the regular expression `[0-9]+(ms|s|m|h|d|w|y)`
                (milliseconds seconds minutes hours days weeks years).
              type: string
            routePrefix:
              description: The route prefix Prometheus registers HTTP handlers for.
                This is useful, if using ExternalURL and a proxy is rewriting HTTP
                routes of a request, and the actual ExternalURL is still true, but
                the server serves requests under a different route prefix. For example
                for use with `kubectl proxy`.
              type: string
            ruleNamespaceSelector:
              description: A label selector is a label query over a set of resources.
                The result of matchLabels and matchExpressions are ANDed. An empty
                label selector matches all objects. A null label selector matches
                no objects.
              properties:
                matchExpressions:
                  description: matchExpressions is a list of label selector requirements.
                    The requirements are ANDed.
                  items:
                    description: A label selector requirement is a selector that contains
                      values, a key, and an operator that relates the key and values.
                    properties:
                      key:
                        description: key is the label key that the selector applies
                          to.
                        type: string
                      operator:
                        description: operator represents a key's relationship to a
                          set of values. Valid operators are In, NotIn, Exists and
                          DoesNotExist.
                        type: string
                      values:
                        description: values is an array of string values. If the operator
                          is In or NotIn, the values array must be non-empty. If the
                          operator is Exists or DoesNotExist, the values array must
                          be empty. This array is replaced during a strategic merge
                          patch.
                        items:
                          type: string
                        type: array
                    required:
                    - key
                    - operator
                  type: array
                matchLabels:
                  description: matchLabels is a map of {key,value} pairs. A single
                    {key,value} in the matchLabels map is equivalent to an element
                    of matchExpressions, whose key field is "key", the operator is
                    "In", and the values array contains only "value". The requirements
                    are ANDed.
                  type: object
            ruleSelector:
              description: A label selector is a label query over a set of resources.
                The result of matchLabels and matchExpressions are ANDed. An empty
                label selector matches all objects. A null label selector matches
                no objects.
              properties:
                matchExpressions:
                  description: matchExpressions is a list of label selector requirements.
                    The requirements are ANDed.
                  items:
                    description: A label selector requirement is a selector that contains
                      values, a key, and an operator that relates the key and values.
                    properties:
                      key:
                        description: key is the label key that the selector applies
                          to.
                        type: string
                      operator:
                        description: operator represents a key's relationship to a
                          set of values. Valid operators are In, NotIn, Exists and
                          DoesNotExist.
                        type: string
                      values:
                        description: values is an array of string values. If the operator
                          is In or NotIn, the values array must be non-empty. If the
                          operator is Exists or DoesNotExist, the values array must
                          be empty. This array is replaced during a strategic merge
                          patch.
                        items:
                          type: string
                        type: array
                    required:
                    - key
                    - operator
                  type: array
                matchLabels:
                  description: matchLabels is a map of {key,value} pairs. A single
                    {key,value} in the matchLabels map is equivalent to an element
                    of matchExpressions, whose key field is "key", the operator is
                    "In", and the values array contains only "value". The requirements
                    are ANDed.
                  type: object
            rules:
              description: /--rules.*/ command-line arguments
              properties:
                alert:
                  description: /--rules.alert.*/ command-line arguments
                  properties:
                    forGracePeriod:
                      description: Minimum duration between alert and restored 'for'
                        state. This is maintained only for alerts with configured
                        'for' time greater than grace period.
                      type: string
                    forOutageTolerance:
                      description: Max time to tolerate prometheus outage for restoring
                        'for' state of alert.
                      type: string
                    resendDelay:
                      description: Minimum amount of time to wait before resending
                        an alert to Alertmanager.
                      type: string
            scrapeInterval:
              description: Interval between consecutive scrapes.
              type: string
            secrets:
              description: Secrets is a list of Secrets in the same namespace as the
                Prometheus object, which shall be mounted into the Prometheus Pods.
                The Secrets are mounted into /etc/prometheus/secrets/<secret-name>.
              items:
                type: string
              type: array
            securityContext:
              description: PodSecurityContext holds pod-level security attributes
                and common container settings. Some fields are also present in container.securityContext.  Field
                values of container.securityContext take precedence over field values
                of PodSecurityContext.
              properties:
                fsGroup:
                  description: |-
                    A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:

                    1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----

                    If unset, the Kubelet will not modify the ownership and permissions of any volume.
                  format: int64
                  type: integer
                runAsGroup:
                  description: The GID to run the entrypoint of the container process.
                    Uses runtime default if unset. May also be set in SecurityContext.  If
                    set in both SecurityContext and PodSecurityContext, the value
                    specified in SecurityContext takes precedence for that container.
                  format: int64
                  type: integer
                runAsNonRoot:
                  description: Indicates that the container must run as a non-root
                    user. If true, the Kubelet will validate the image at runtime
                    to ensure that it does not run as UID 0 (root) and fail to start
                    the container if it does. If unset or false, no such validation
                    will be performed. May also be set in SecurityContext.  If set
                    in both SecurityContext and PodSecurityContext, the value specified
                    in SecurityContext takes precedence.
                  type: boolean
                runAsUser:
                  description: The UID to run the entrypoint of the container process.
                    Defaults to user specified in image metadata if unspecified. May
                    also be set in SecurityContext.  If set in both SecurityContext
                    and PodSecurityContext, the value specified in SecurityContext
                    takes precedence for that container.
                  format: int64
                  type: integer
                seLinuxOptions:
                  description: SELinuxOptions are the labels to be applied to the
                    container
                  properties:
                    level:
                      description: Level is SELinux level label that applies to the
                        container.
                      type: string
                    role:
                      description: Role is a SELinux role label that applies to the
                        container.
                      type: string
                    type:
                      description: Type is a SELinux type label that applies to the
                        container.
                      type: string
                    user:
                      description: User is a SELinux user label that applies to the
                        container.
                      type: string
                supplementalGroups:
                  description: A list of groups applied to the first process run in
                    each container, in addition to the container's primary GID.  If
                    unspecified, no groups will be added to any container.
                  items:
                    format: int64
                    type: integer
                  type: array
                sysctls:
                  description: Sysctls hold a list of namespaced sysctls used for
                    the pod. Pods with unsupported sysctls (by the container runtime)
                    might fail to launch.
                  items:
                    description: Sysctl defines a kernel parameter to be set
                    properties:
                      name:
                        description: Name of a property to set
                        type: string
                      value:
                        description: Value of a property to set
                        type: string
                    required:
                    - name
                    - value
                  type: array
            serviceAccountName:
              description: ServiceAccountName is the name of the ServiceAccount to
                use to run the Prometheus Pods.
              type: string
            serviceMonitorNamespaceSelector:
              description: A label selector is a label query over a set of resources.
                The result of matchLabels and matchExpressions are ANDed. An empty
                label selector matches all objects. A null label selector matches
                no objects.
              properties:
                matchExpressions:
                  description: matchExpressions is a list of label selector requirements.
                    The requirements are ANDed.
                  items:
                    description: A label selector requirement is a selector that contains
                      values, a key, and an operator that relates the key and values.
                    properties:
                      key:
                        description: key is the label key that the selector applies
                          to.
                        type: string
                      operator:
                        description: operator represents a key's relationship to a
                          set of values. Valid operators are In, NotIn, Exists and
                          DoesNotExist.
                        type: string
                      values:
                        description: values is an array of string values. If the operator
                          is In or NotIn, the values array must be non-empty. If the
                          operator is Exists or DoesNotExist, the values array must
                          be empty. This array is replaced during a strategic merge
                          patch.
                        items:
                          type: string
                        type: array
                    required:
                    - key
                    - operator
                  type: array
                matchLabels:
                  description: matchLabels is a map of {key,value} pairs. A single
                    {key,value} in the matchLabels map is equivalent to an element
                    of matchExpressions, whose key field is "key", the operator is
                    "In", and the values array contains only "value". The requirements
                    are ANDed.
                  type: object
            serviceMonitorSelector:
              description: A label selector is a label query over a set of resources.
                The result of matchLabels and matchExpressions are ANDed. An empty
                label selector matches all objects. A null label selector matches
                no objects.
              properties:
                matchExpressions:
                  description: matchExpressions is a list of label selector requirements.
                    The requirements are ANDed.
                  items:
                    description: A label selector requirement is a selector that contains
                      values, a key, and an operator that relates the key and values.
                    properties:
                      key:
                        description: key is the label key that the selector applies
                          to.
                        type: string
                      operator:
                        description: operator represents a key's relationship to a
                          set of values. Valid operators are In, NotIn, Exists and
                          DoesNotExist.
                        type: string
                      values:
                        description: values is an array of string values. If the operator
                          is In or NotIn, the values array must be non-empty. If the
                          operator is Exists or DoesNotExist, the values array must
                          be empty. This array is replaced during a strategic merge
                          patch.
                        items:
                          type: string
                        type: array
                    required:
                    - key
                    - operator
                  type: array
                matchLabels:
                  description: matchLabels is a map of {key,value} pairs. A single
                    {key,value} in the matchLabels map is equivalent to an element
                    of matchExpressions, whose key field is "key", the operator is
                    "In", and the values array contains only "value". The requirements
                    are ANDed.
                  type: object
            sha:
              description: SHA of Prometheus container image to be deployed. Defaults
                to the value of `version`. Similar to a tag, but the SHA explicitly
                deploys an immutable container image. Version and Tag are ignored
                if SHA is set.
              type: string
            storage:
              description: StorageSpec defines the configured storage for a group
                Prometheus servers. If neither `emptyDir` nor `volumeClaimTemplate`
                is specified, then by default an [EmptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
                will be used.
              properties:
                emptyDir:
                  description: Represents an empty directory for a pod. Empty directory
                    volumes support ownership management and SELinux relabeling.
                  properties:
                    medium:
                      description: 'What type of storage medium should back this directory.
                        The default is "" which means to use the node''s default medium.
                        Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir'
                      type: string
                    sizeLimit: {}
                volumeClaimTemplate:
                  description: PersistentVolumeClaim is a user's request for and claim
                    to a persistent volume
                  properties:
                    apiVersion:
                      description: 'APIVersion defines the versioned schema of this
                        representation of an object. Servers should convert recognized
                        schemas to the latest internal value, and may reject unrecognized
                        values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                      type: string
                    kind:
                      description: 'Kind is a string value representing the REST resource
                        this object represents. Servers may infer this from the endpoint
                        the client submits requests to. Cannot be updated. In CamelCase.
                        More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                      type: string
                    metadata:
                      description: ObjectMeta is metadata that all persisted resources
                        must have, which includes all objects users must create.
                      properties:
                        annotations:
                          description: 'Annotations is an unstructured key value map
                            stored with a resource that may be set by external tools
                            to store and retrieve arbitrary metadata. They are not
                            queryable and should be preserved when modifying objects.
                            More info: http://kubernetes.io/docs/user-guide/annotations'
                          type: object
                        clusterName:
                          description: The name of the cluster which the object belongs
                            to. This is used to distinguish resources with same name
                            and namespace in different clusters. This field is not
                            set anywhere right now and apiserver is going to ignore
                            it if set in create or update request.
                          type: string
                        creationTimestamp:
                          description: Time is a wrapper around time.Time which supports
                            correct marshaling to YAML and JSON.  Wrappers are provided
                            for many of the factory methods that the time package
                            offers.
                          format: date-time
                          type: string
                        deletionGracePeriodSeconds:
                          description: Number of seconds allowed for this object to
                            gracefully terminate before it will be removed from the
                            system. Only set when deletionTimestamp is also set. May
                            only be shortened. Read-only.
                          format: int64
                          type: integer
                        deletionTimestamp:
                          description: Time is a wrapper around time.Time which supports
                            correct marshaling to YAML and JSON.  Wrappers are provided
                            for many of the factory methods that the time package
                            offers.
                          format: date-time
                          type: string
                        finalizers:
                          description: Must be empty before the object is deleted
                            from the registry. Each entry is an identifier for the
                            responsible component that will remove the entry from
                            the list. If the deletionTimestamp of the object is non-nil,
                            entries in this list can only be removed.
                          items:
                            type: string
                          type: array
                        generateName:
                          description: |-
                            GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.

                            If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).

                            Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
                          type: string
                        generation:
                          description: A sequence number representing a specific generation
                            of the desired state. Populated by the system. Read-only.
                          format: int64
                          type: integer
                        initializers:
                          description: Initializers tracks the progress of initialization.
                          properties:
                            pending:
                              description: Pending is a list of initializers that
                                must execute in order before this object is visible.
                                When the last pending initializer is removed, and
                                no failing result is set, the initializers struct
                                will be set to nil and the object is considered as
                                initialized and visible to all clients.
                              items:
                                description: Initializer is information about an initializer
                                  that has not yet completed.
                                properties:
                                  name:
                                    description: name of the process that is responsible
                                      for initializing this object.
                                    type: string
                                required:
                                - name
                              type: array
                            result:
                              description: Status is a return value for calls that
                                don't return other objects.
                              properties:
                                apiVersion:
                                  description: 'APIVersion defines the versioned schema
                                    of this representation of an object. Servers should
                                    convert recognized schemas to the latest internal
                                    value, and may reject unrecognized values. More
                                    info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                                  type: string
                                code:
                                  description: Suggested HTTP return code for this
                                    status, 0 if not set.
                                  format: int32
                                  type: integer
                                details:
                                  description: StatusDetails is a set of additional
                                    properties that MAY be set by the server to provide
                                    additional information about a response. The Reason
                                    field of a Status object defines what attributes
                                    will be set. Clients must ignore fields that do
                                    not match the defined type of each attribute,
                                    and should assume that any attribute may be empty,
                                    invalid, or under defined.
                                  properties:
                                    causes:
                                      description: The Causes array includes more
                                        details associated with the StatusReason failure.
                                        Not all StatusReasons may provide detailed
                                        causes.
                                      items:
                                        description: StatusCause provides more information
                                          about an api.Status failure, including cases
                                          when multiple errors are encountered.
                                        properties:
                                          field:
                                            description: |-
                                              The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

                                              Examples:
                                                "name" - the field "name" on the current resource
                                                "items[0].name" - the field "name" on the first array entry in "items"
                                            type: string
                                          message:
                                            description: A human-readable description
                                              of the cause of the error.  This field
                                              may be presented as-is to a reader.
                                            type: string
                                          reason:
                                            description: A machine-readable description
                                              of the cause of the error. If this value
                                              is empty there is no information available.
                                            type: string
                                      type: array
                                    group:
                                      description: The group attribute of the resource
                                        associated with the status StatusReason.
                                      type: string
                                    kind:
                                      description: 'The kind attribute of the resource
                                        associated with the status StatusReason. On
                                        some operations may differ from the requested
                                        resource Kind. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                      type: string
                                    name:
                                      description: The name attribute of the resource
                                        associated with the status StatusReason (when
                                        there is a single name which can be described).
                                      type: string
                                    retryAfterSeconds:
                                      description: If specified, the time in seconds
                                        before the operation should be retried. Some
                                        errors may indicate the client must take an
                                        alternate action - for those errors this field
                                        may indicate how long to wait before taking
                                        the alternate action.
                                      format: int32
                                      type: integer
                                    uid:
                                      description: 'UID of the resource. (when there
                                        is a single resource which can be described).
                                        More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                                      type: string
                                kind:
                                  description: 'Kind is a string value representing
                                    the REST resource this object represents. Servers
                                    may infer this from the endpoint the client submits
                                    requests to. Cannot be updated. In CamelCase.
                                    More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                  type: string
                                message:
                                  description: A human-readable description of the
                                    status of this operation.
                                  type: string
                                metadata:
                                  description: ListMeta describes metadata that synthetic
                                    resources must have, including lists and various
                                    status objects. A resource may have only one of
                                    {ObjectMeta, ListMeta}.
                                  properties:
                                    continue:
                                      description: continue may be set if the user
                                        set a limit on the number of items returned,
                                        and indicates that the server has more data
                                        available. The value is opaque and may be
                                        used to issue another request to the endpoint
                                        that served this list to retrieve the next
                                        set of available objects. Continuing a consistent
                                        list may not be possible if the server configuration
                                        has changed or more than a few minutes have
                                        passed. The resourceVersion field returned
                                        when using this continue value will be identical
                                        to the value in the first response, unless
                                        you have received this token from an error
                                        message.
                                      type: string
                                    resourceVersion:
                                      description: 'String that identifies the server''s
                                        internal version of this object that can be
                                        used by clients to determine when objects
                                        have changed. Value must be treated as opaque
                                        by clients and passed unmodified back to the
                                        server. Populated by the system. Read-only.
                                        More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency'
                                      type: string
                                    selfLink:
                                      description: selfLink is a URL representing
                                        this object. Populated by the system. Read-only.
                                      type: string
                                reason:
                                  description: A machine-readable description of why
                                    this operation is in the "Failure" status. If
                                    this value is empty there is no information available.
                                    A Reason clarifies an HTTP status code but does
                                    not override it.
                                  type: string
                                status:
                                  description: 'Status of the operation. One of: "Success"
                                    or "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status'
                                  type: string
                          required:
                          - pending
                        labels:
                          description: 'Map of string keys and values that can be
                            used to organize and categorize (scope and select) objects.
                            May match selectors of replication controllers and services.
                            More info: http://kubernetes.io/docs/user-guide/labels'
                          type: object
                        name:
                          description: 'Name must be unique within a namespace. Is
                            required when creating resources, although some resources
                            may allow a client to request the generation of an appropriate
                            name automatically. Name is primarily intended for creation
                            idempotence and configuration definition. Cannot be updated.
                            More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                          type: string
                        namespace:
                          description: |-
                            Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.

                            Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
                          type: string
                        ownerReferences:
                          description: List of objects depended by this object. If
                            ALL objects in the list have been deleted, this object
                            will be garbage collected. If this object is managed by
                            a controller, then an entry in this list will point to
                            this controller, with the controller field set to true.
                            There cannot be more than one managing controller.
                          items:
                            description: OwnerReference contains enough information
                              to let you identify an owning object. Currently, an
                              owning object must be in the same namespace, so there
                              is no namespace field.
                            properties:
                              apiVersion:
                                description: API version of the referent.
                                type: string
                              blockOwnerDeletion:
                                description: If true, AND if the owner has the "foregroundDeletion"
                                  finalizer, then the owner cannot be deleted from
                                  the key-value store until this reference is removed.
                                  Defaults to false. To set this field, a user needs
                                  "delete" permission of the owner, otherwise 422
                                  (Unprocessable Entity) will be returned.
                                type: boolean
                              controller:
                                description: If true, this reference points to the
                                  managing controller.
                                type: boolean
                              kind:
                                description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                                type: string
                              name:
                                description: 'Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                                type: string
                              uid:
                                description: 'UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                                type: string
                            required:
                            - apiVersion
                            - kind
                            - name
                            - uid
                          type: array
                        resourceVersion:
                          description: |-
                            An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.

                            Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
                          type: string
                        selfLink:
                          description: SelfLink is a URL representing this object.
                            Populated by the system. Read-only.
                          type: string
                        uid:
                          description: |-
                            UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.

                            Populated by the system. Read-only. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
                          type: string
                    spec:
                      description: PersistentVolumeClaimSpec describes the common
                        attributes of storage devices and allows a Source for provider-specific
                        attributes
                      properties:
                        accessModes:
                          description: 'AccessModes contains the desired access modes
                            the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1'
                          items:
                            type: string
                          type: array
                        dataSource:
                          description: TypedLocalObjectReference contains enough information
                            to let you locate the typed referenced object inside the
                            same namespace.
                          properties:
                            apiGroup:
                              description: APIGroup is the group for the resource
                                being referenced. If APIGroup is not specified, the
                                specified Kind must be in the core API group. For
                                any other third-party types, APIGroup is required.
                              type: string
                            kind:
                              description: Kind is the type of resource being referenced
                              type: string
                            name:
                              description: Name is the name of resource being referenced
                              type: string
                          required:
                          - kind
                          - name
                        resources:
                          description: ResourceRequirements describes the compute
                            resource requirements.
                          properties:
                            limits:
                              description: 'Limits describes the maximum amount of
                                compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                              type: object
                            requests:
                              description: 'Requests describes the minimum amount
                                of compute resources required. If Requests is omitted
                                for a container, it defaults to Limits if that is
                                explicitly specified, otherwise to an implementation-defined
                                value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                              type: object
                        selector:
                          description: A label selector is a label query over a set
                            of resources. The result of matchLabels and matchExpressions
                            are ANDed. An empty label selector matches all objects.
                            A null label selector matches no objects.
                          properties:
                            matchExpressions:
                              description: matchExpressions is a list of label selector
                                requirements. The requirements are ANDed.
                              items:
                                description: A label selector requirement is a selector
                                  that contains values, a key, and an operator that
                                  relates the key and values.
                                properties:
                                  key:
                                    description: key is the label key that the selector
                                      applies to.
                                    type: string
                                  operator:
                                    description: operator represents a key's relationship
                                      to a set of values. Valid operators are In,
                                      NotIn, Exists and DoesNotExist.
                                    type: string
                                  values:
                                    description: values is an array of string values.
                                      If the operator is In or NotIn, the values array
                                      must be non-empty. If the operator is Exists
                                      or DoesNotExist, the values array must be empty.
                                      This array is replaced during a strategic merge
                                      patch.
                                    items:
                                      type: string
                                    type: array
                                required:
                                - key
                                - operator
                              type: array
                            matchLabels:
                              description: matchLabels is a map of {key,value} pairs.
                                A single {key,value} in the matchLabels map is equivalent
                                to an element of matchExpressions, whose key field
                                is "key", the operator is "In", and the values array
                                contains only "value". The requirements are ANDed.
                              type: object
                        storageClassName:
                          description: 'Name of the StorageClass required by the claim.
                            More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1'
                          type: string
                        volumeMode:
                          description: volumeMode defines what type of volume is required
                            by the claim. Value of Filesystem is implied when not
                            included in claim spec. This is an alpha feature and may
                            change in the future.
                          type: string
                        volumeName:
                          description: VolumeName is the binding reference to the
                            PersistentVolume backing this claim.
                          type: string
                    status:
                      description: PersistentVolumeClaimStatus is the current status
                        of a persistent volume claim.
                      properties:
                        accessModes:
                          description: 'AccessModes contains the actual access modes
                            the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1'
                          items:
                            type: string
                          type: array
                        capacity:
                          description: Represents the actual resources of the underlying
                            volume.
                          type: object
                        conditions:
                          description: Current Condition of persistent volume claim.
                            If underlying persistent volume is being resized then
                            the Condition will be set to 'ResizeStarted'.
                          items:
                            description: PersistentVolumeClaimCondition contails details
                              about state of pvc
                            properties:
                              lastProbeTime:
                                description: Time is a wrapper around time.Time which
                                  supports correct marshaling to YAML and JSON.  Wrappers
                                  are provided for many of the factory methods that
                                  the time package offers.
                                format: date-time
                                type: string
                              lastTransitionTime:
                                description: Time is a wrapper around time.Time which
                                  supports correct marshaling to YAML and JSON.  Wrappers
                                  are provided for many of the factory methods that
                                  the time package offers.
                                format: date-time
                                type: string
                              message:
                                description: Human-readable message indicating details
                                  about last transition.
                                type: string
                              reason:
                                description: Unique, this should be a short, machine
                                  understandable string that gives the reason for
                                  condition's last transition. If it reports "ResizeStarted"
                                  that means the underlying persistent volume is being
                                  resized.
                                type: string
                              status:
                                type: string
                              type:
                                type: string
                            required:
                            - type
                            - status
                          type: array
                        phase:
                          description: Phase represents the current phase of PersistentVolumeClaim.
                          type: string
            tag:
              description: Tag of Prometheus container image to be deployed. Defaults
                to the value of `version`. Version is ignored if Tag is set.
              type: string
            thanos:
              description: ThanosSpec defines parameters for a Prometheus server within
                a Thanos deployment.
              properties:
                baseImage:
                  description: Thanos base image if other than default.
                  type: string
                gcs:
                  description: 'Deprecated: ThanosGCSSpec should be configured with
                    an ObjectStorageConfig secret starting with Thanos v0.2.0. ThanosGCSSpec
                    will be removed.'
                  properties:
                    bucket:
                      description: Google Cloud Storage bucket name for stored blocks.
                        If empty it won't store any block inside Google Cloud Storage.
                      type: string
                    credentials:
                      description: SecretKeySelector selects a key of a Secret.
                      properties:
                        key:
                          description: The key of the secret to select from.  Must
                            be a valid secret key.
                          type: string
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                          type: string
                        optional:
                          description: Specify whether the Secret or it's key must
                            be defined
                          type: boolean
                      required:
                      - key
                image:
                  description: Image if specified has precedence over baseImage, tag
                    and sha combinations. Specifying the version is still necessary
                    to ensure the Prometheus Operator knows what version of Thanos
                    is being configured.
                  type: string
                objectStorageConfig:
                  description: SecretKeySelector selects a key of a Secret.
                  properties:
                    key:
                      description: The key of the secret to select from.  Must be
                        a valid secret key.
                      type: string
                    name:
                      description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                      type: string
                    optional:
                      description: Specify whether the Secret or it's key must be
                        defined
                      type: boolean
                  required:
                  - key
                peers:
                  description: Peers is a DNS name for Thanos to discover peers through.
                  type: string
                resources:
                  description: ResourceRequirements describes the compute resource
                    requirements.
                  properties:
                    limits:
                      description: 'Limits describes the maximum amount of compute
                        resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                      type: object
                    requests:
                      description: 'Requests describes the minimum amount of compute
                        resources required. If Requests is omitted for a container,
                        it defaults to Limits if that is explicitly specified, otherwise
                        to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/'
                      type: object
                s3:
                  description: 'Deprecated: ThanosS3Spec should be configured with
                    an ObjectStorageConfig secret starting with Thanos v0.2.0. ThanosS3Spec
                    will be removed.'
                  properties:
                    accessKey:
                      description: SecretKeySelector selects a key of a Secret.
                      properties:
                        key:
                          description: The key of the secret to select from.  Must
                            be a valid secret key.
                          type: string
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                          type: string
                        optional:
                          description: Specify whether the Secret or it's key must
                            be defined
                          type: boolean
                      required:
                      - key
                    bucket:
                      description: S3-Compatible API bucket name for stored blocks.
                      type: string
                    encryptsse:
                      description: Whether to use Server Side Encryption
                      type: boolean
                    endpoint:
                      description: S3-Compatible API endpoint for stored blocks.
                      type: string
                    insecure:
                      description: Whether to use an insecure connection with an S3-Compatible
                        API.
                      type: boolean
                    secretKey:
                      description: SecretKeySelector selects a key of a Secret.
                      properties:
                        key:
                          description: The key of the secret to select from.  Must
                            be a valid secret key.
                          type: string
                        name:
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                          type: string
                        optional:
                          description: Specify whether the Secret or it's key must
                            be defined
                          type: boolean
                      required:
                      - key
                    signatureVersion2:
                      description: Whether to use S3 Signature Version 2; otherwise
                        Signature Version 4 will be used.
                      type: boolean
                sha:
                  description: SHA of Thanos container image to be deployed. Defaults
                    to the value of `version`. Similar to a tag, but the SHA explicitly
                    deploys an immutable container image. Version and Tag are ignored
                    if SHA is set.
                  type: string
                tag:
                  description: Tag of Thanos sidecar container image to be deployed.
                    Defaults to the value of `version`. Version is ignored if Tag
                    is set.
                  type: string
                version:
                  description: Version describes the version of Thanos to use.
                  type: string
            tolerations:
              description: If specified, the pod's tolerations.
              items:
                description: The pod this Toleration is attached to tolerates any
                  taint that matches the triple <key,value,effect> using the matching
                  operator <operator>.
                properties:
                  effect:
                    description: Effect indicates the taint effect to match. Empty
                      means match all taint effects. When specified, allowed values
                      are NoSchedule, PreferNoSchedule and NoExecute.
                    type: string
                  key:
                    description: Key is the taint key that the toleration applies
                      to. Empty means match all taint keys. If the key is empty, operator
                      must be Exists; this combination means to match all values and
                      all keys.
                    type: string
                  operator:
                    description: Operator represents a key's relationship to the value.
                      Valid operators are Exists and Equal. Defaults to Equal. Exists
                      is equivalent to wildcard for value, so that a pod can tolerate
                      all taints of a particular category.
                    type: string
                  tolerationSeconds:
                    description: TolerationSeconds represents the period of time the
                      toleration (which must be of effect NoExecute, otherwise this
                      field is ignored) tolerates the taint. By default, it is not
                      set, which means tolerate the taint forever (do not evict).
                      Zero and negative values will be treated as 0 (evict immediately)
                      by the system.
                    format: int64
                    type: integer
                  value:
                    description: Value is the taint value the toleration matches to.
                      If the operator is Exists, the value should be empty, otherwise
                      just a regular string.
                    type: string
              type: array
            version:
              description: Version of Prometheus to be deployed.
              type: string
        status:
          description: 'PrometheusStatus is the most recent observed status of the
            Prometheus cluster. Read-only. Not included when requesting from the apiserver,
            only from the Prometheus Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md#spec-and-status'
          properties:
            availableReplicas:
              description: Total number of available pods (ready for at least minReadySeconds)
                targeted by this Prometheus deployment.
              format: int32
              type: integer
            paused:
              description: Represents whether any actions on the underlaying managed
                objects are being performed. Only delete actions will be performed.
              type: boolean
            replicas:
              description: Total number of non-terminated pods targeted by this Prometheus
                deployment (their labels match the selector).
              format: int32
              type: integer
            unavailableReplicas:
              description: Total number of unavailable pods targeted by this Prometheus
                deployment.
              format: int32
              type: integer
            updatedReplicas:
              description: Total number of non-terminated pods targeted by this Prometheus
                deployment that have the desired version spec.
              format: int32
              type: integer
          required:
          - paused
          - replicas
          - updatedReplicas
          - availableReplicas
          - unavailableReplicas
  version: v1
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  creationTimestamp: null
  name: prometheusrules.monitoring.coreos.com
spec:
  group: monitoring.coreos.com
  names:
    kind: PrometheusRule
    plural: prometheusrules
  scope: Namespaced
  validation:
    openAPIV3Schema:
      properties:
        apiVersion:
          description: 'APIVersion defines the versioned schema of this representation
            of an object. Servers should convert recognized schemas to the latest
            internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
          type: string
        kind:
          description: 'Kind is a string value representing the REST resource this
            object represents. Servers may infer this from the endpoint the client
            submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
          type: string
        metadata:
          description: ObjectMeta is metadata that all persisted resources must have,
            which includes all objects users must create.
          properties:
            annotations:
              description: 'Annotations is an unstructured key value map stored with
                a resource that may be set by external tools to store and retrieve
                arbitrary metadata. They are not queryable and should be preserved
                when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations'
              type: object
            clusterName:
              description: The name of the cluster which the object belongs to. This
                is used to distinguish resources with same name and namespace in different
                clusters. This field is not set anywhere right now and apiserver is
                going to ignore it if set in create or update request.
              type: string
            creationTimestamp:
              description: Time is a wrapper around time.Time which supports correct
                marshaling to YAML and JSON.  Wrappers are provided for many of the
                factory methods that the time package offers.
              format: date-time
              type: string
            deletionGracePeriodSeconds:
              description: Number of seconds allowed for this object to gracefully
                terminate before it will be removed from the system. Only set when
                deletionTimestamp is also set. May only be shortened. Read-only.
              format: int64
              type: integer
            deletionTimestamp:
              description: Time is a wrapper around time.Time which supports correct
                marshaling to YAML and JSON.  Wrappers are provided for many of the
                factory methods that the time package offers.
              format: date-time
              type: string
            finalizers:
              description: Must be empty before the object is deleted from the registry.
                Each entry is an identifier for the responsible component that will
                remove the entry from the list. If the deletionTimestamp of the object
                is non-nil, entries in this list can only be removed.
              items:
                type: string
              type: array
            generateName:
              description: |-
                GenerateName is an optional prefix, used by the server, to generate a unique name ONLY IF the Name field has not been provided. If this field is used, the name returned to the client will be different than the name passed. This value will also be combined with a unique suffix. The provided value has the same validation rules as the Name field, and may be truncated by the length of the suffix required to make the value unique on the server.

                If this field is specified and the generated name exists, the server will NOT return a 409 - instead, it will either return 201 Created or 500 with Reason ServerTimeout indicating a unique name could not be found in the time allotted, and the client should retry (optionally after the time indicated in the Retry-After header).

                Applied only if Name is not specified. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#idempotency
              type: string
            generation:
              description: A sequence number representing a specific generation of
                the desired state. Populated by the system. Read-only.
              format: int64
              type: integer
            initializers:
              description: Initializers tracks the progress of initialization.
              properties:
                pending:
                  description: Pending is a list of initializers that must execute
                    in order before this object is visible. When the last pending
                    initializer is removed, and no failing result is set, the initializers
                    struct will be set to nil and the object is considered as initialized
                    and visible to all clients.
                  items:
                    description: Initializer is information about an initializer that
                      has not yet completed.
                    properties:
                      name:
                        description: name of the process that is responsible for initializing
                          this object.
                        type: string
                    required:
                    - name
                  type: array
                result:
                  description: Status is a return value for calls that don't return
                    other objects.
                  properties:
                    apiVersion:
                      description: 'APIVersion defines the versioned schema of this
                        representation of an object. Servers should convert recognized
                        schemas to the latest internal value, and may reject unrecognized
                        values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
                      type: string
                    code:
                      description: Suggested HTTP return code for this status, 0 if
                        not set.
                      format: int32
                      type: integer
                    details:
                      description: StatusDetails is a set of additional properties
                        that MAY be set by the server to provide additional information
                        about a response. The Reason field of a Status object defines
                        what attributes will be set. Clients must ignore fields that
                        do not match the defined type of each attribute, and should
                        assume that any attribute may be empty, invalid, or under
                        defined.
                      properties:
                        causes:
                          description: The Causes array includes more details associated
                            with the StatusReason failure. Not all StatusReasons may
                            provide detailed causes.
                          items:
                            description: StatusCause provides more information about
                              an api.Status failure, including cases when multiple
                              errors are encountered.
                            properties:
                              field:
                                description: |-
                                  The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

                                  Examples:
                                    "name" - the field "name" on the current resource
                                    "items[0].name" - the field "name" on the first array entry in "items"
                                type: string
                              message:
                                description: A human-readable description of the cause
                                  of the error.  This field may be presented as-is
                                  to a reader.
                                type: string
                              reason:
                                description: A machine-readable description of the
                                  cause of the error. If this value is empty there
                                  is no information available.
                                type: string
                          type: array
                        group:
                          description: The group attribute of the resource associated
                            with the status StatusReason.
                          type: string
                        kind:
                          description: 'The kind attribute of the resource associated
                            with the status StatusReason. On some operations may differ
                            from the requested resource Kind. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                          type: string
                        name:
                          description: The name attribute of the resource associated
                            with the status StatusReason (when there is a single name
                            which can be described).
                          type: string
                        retryAfterSeconds:
                          description: If specified, the time in seconds before the
                            operation should be retried. Some errors may indicate
                            the client must take an alternate action - for those errors
                            this field may indicate how long to wait before taking
                            the alternate action.
                          format: int32
                          type: integer
                        uid:
                          description: 'UID of the resource. (when there is a single
                            resource which can be described). More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                          type: string
                    kind:
                      description: 'Kind is a string value representing the REST resource
                        this object represents. Servers may infer this from the endpoint
                        the client submits requests to. Cannot be updated. In CamelCase.
                        More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                      type: string
                    message:
                      description: A human-readable description of the status of this
                        operation.
                      type: string
                    metadata:
                      description: ListMeta describes metadata that synthetic resources
                        must have, including lists and various status objects. A resource
                        may have only one of {ObjectMeta, ListMeta}.
                      properties:
                        continue:
                          description: continue may be set if the user set a limit
                            on the number of items returned, and indicates that the
                            server has more data available. The value is opaque and
                            may be used to issue another request to the endpoint that
                            served this list to retrieve the next set of available
                            objects. Continuing a consistent list may not be possible
                            if the server configuration has changed or more than a
                            few minutes have passed. The resourceVersion field returned
                            when using this continue value will be identical to the
                            value in the first response, unless you have received
                            this token from an error message.
                          type: string
                        resourceVersion:
                          description: 'String that identifies the server''s internal
                            version of this object that can be used by clients to
                            determine when objects have changed. Value must be treated
                            as opaque by clients and passed unmodified back to the
                            server. Populated by the system. Read-only. More info:
                            https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency'
                          type: string
                        selfLink:
                          description: selfLink is a URL representing this object.
                            Populated by the system. Read-only.
                          type: string
                    reason:
                      description: A machine-readable description of why this operation
                        is in the "Failure" status. If this value is empty there is
                        no information available. A Reason clarifies an HTTP status
                        code but does not override it.
                      type: string
                    status:
                      description: 'Status of the operation. One of: "Success" or
                        "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status'
                      type: string
              required:
              - pending
            labels:
              description: 'Map of string keys and values that can be used to organize
                and categorize (scope and select) objects. May match selectors of
                replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels'
              type: object
            name:
              description: 'Name must be unique within a namespace. Is required when
                creating resources, although some resources may allow a client to
                request the generation of an appropriate name automatically. Name
                is primarily intended for creation idempotence and configuration definition.
                Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
              type: string
            namespace:
              description: |-
                Namespace defines the space within each name must be unique. An empty namespace is equivalent to the "default" namespace, but "default" is the canonical representation. Not all objects are required to be scoped to a namespace - the value of this field for those objects will be empty.

                Must be a DNS_LABEL. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/namespaces
              type: string
            ownerReferences:
              description: List of objects depended by this object. If ALL objects
                in the list have been deleted, this object will be garbage collected.
                If this object is managed by a controller, then an entry in this list
                will point to this controller, with the controller field set to true.
                There cannot be more than one managing controller.
              items:
                description: OwnerReference contains enough information to let you
                  identify an owning object. Currently, an owning object must be in
                  the same namespace, so there is no namespace field.
                properties:
                  apiVersion:
                    description: API version of the referent.
                    type: string
                  blockOwnerDeletion:
                    description: If true, AND if the owner has the "foregroundDeletion"
                      finalizer, then the owner cannot be deleted from the key-value
                      store until this reference is removed. Defaults to false. To
                      set this field, a user needs "delete" permission of the owner,
                      otherwise 422 (Unprocessable Entity) will be returned.
                    type: boolean
                  controller:
                    description: If true, this reference points to the managing controller.
                    type: boolean
                  kind:
                    description: 'Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
                    type: string
                  name:
                    description: 'Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names'
                    type: string
                  uid:
                    description: 'UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids'
                    type: string
                required:
                - apiVersion
                - kind
                - name
                - uid
              type: array
            resourceVersion:
              description: |-
                An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. Clients must treat these values as opaque and passed unmodified back to the server. They may only be valid for a particular resource or set of resources.

                Populated by the system. Read-only. Value must be treated as opaque by clients and . More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
              type: string
            selfLink:
              description: SelfLink is a URL representing this object. Populated by
                the system. Read-only.
              type: string
            uid:
              description: |-
                UID is the unique in time and space value for this object. It is typically generated by the server on successful creation of a resource and is not allowed to change on PUT operations.

                Populated by the system. Read-only. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
              type: string
        spec:
          description: PrometheusRuleSpec contains specification parameters for a
            Rule.
          properties:
            groups:
              description: Content of Prometheus rule file
              items:
                description: RuleGroup is a list of sequentially evaluated recording
                  and alerting rules.
                properties:
                  interval:
                    type: string
                  name:
                    type: string
                  rules:
                    items:
                      description: Rule describes an alerting or recording rule.
                      properties:
                        alert:
                          type: string
                        annotations:
                          type: object
                        expr:
                          anyOf:
                          - type: string
                          - type: integer
                        for:
                          type: string
                        labels:
                          type: object
                        record:
                          type: string
                      required:
                      - expr
                    type: array
                required:
                - name
                - rules
              type: array
  version: v1
---
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  creationTimestamp: null
  name: servicemonitors.monitoring.coreos.com
spec:
  group: monitoring.coreos.com
  names:
    kind: ServiceMonitor
    plural: servicemonitors
  scope: Namespaced
  validation:
    openAPIV3Schema:
      properties:
        apiVersion:
          description: 'APIVersion defines the versioned schema of this representation
            of an object. Servers should convert recognized schemas to the latest
            internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources'
          type: string
        kind:
          description: 'Kind is a string value representing the REST resource this
            object represents. Servers may infer this from the endpoint the client
            submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds'
          type: string
        spec:
          description: ServiceMonitorSpec contains specification parameters for a
            ServiceMonitor.
          properties:
            endpoints:
              description: A list of endpoints allowed as part of this ServiceMonitor.
              items:
                description: Endpoint defines a scrapeable endpoint serving Prometheus
                  metrics.
                properties:
                  basicAuth:
                    description: 'BasicAuth allow an endpoint to authenticate over
                      basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints'
                    properties:
                      password:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                      username:
                        description: SecretKeySelector selects a key of a Secret.
                        properties:
                          key:
                            description: The key of the secret to select from.  Must
                              be a valid secret key.
                            type: string
                          name:
                            description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names'
                            type: string
                          optional:
                            description: Specify whether the Secret or it's key must
                              be defined
                            type: boolean
                        required:
                        - key
                  bearerTokenFile:
                    description: File to read bearer token for scraping targets.
                    type: string
                  honorLabels:
                    description: HonorLabels chooses the metric's labels on collisions
                      with target labels.
                    type: boolean
                  interval:
                    description: Interval at which metrics should be scraped
                    type: string
                  metricRelabelings:
                    description: MetricRelabelConfigs to apply to samples before ingestion.
                    items:
                      description: 'RelabelConfig allows dynamic rewriting of the
                        label set, being applied to samples before ingestion. It defines
                        `<metric_relabel_configs>`-section of Prometheus configuration.
                        More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs'
                      properties:
                        action:
                          description: Action to perform based on regex matching.
                            Default is 'replace'
                          type: string
                        modulus:
                          description: Modulus to take of the hash of the source label
                            values.
                          format: int64
                          type: integer
                        regex:
                          description: Regular expression against which the extracted
                            value is matched. defailt is '(.*)'
                          type: string
                        replacement:
                          description: Replacement value against which a regex replace
                            is performed if the regular expression matches. Regex
                            capture groups are available. Default is '$1'
                          type: string
                        separator:
                          description: Separator placed between concatenated source
                            label values. default is ';'.
                          type: string
                        sourceLabels:
                          description: The source labels select values from existing
                            labels. Their content is concatenated using the configured
                            separator and matched against the configured regular expression
                            for the replace, keep, and drop actions.
                          items:
                            type: string
                          type: array
                        targetLabel:
                          description: Label to which the resulting value is written
                            in a replace action. It is mandatory for replace actions.
                            Regex capture groups are available.
                          type: string
                    type: array
                  params:
                    description: Optional HTTP URL parameters
                    type: object
                  path:
                    description: HTTP path to scrape for metrics.
                    type: string
                  port:
                    description: Name of the service port this endpoint refers to.
                      Mutually exclusive with targetPort.
                    type: string
                  proxyUrl:
                    description: ProxyURL eg http://proxyserver:2195 Directs scrapes
                      to proxy through this endpoint.
                    type: string
                  relabelings:
                    description: 'RelabelConfigs to apply to samples before ingestion.
                      More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#<relabel_config>'
                    items:
                      description: 'RelabelConfig allows dynamic rewriting of the
                        label set, being applied to samples before ingestion. It defines
                        `<metric_relabel_configs>`-section of Prometheus configuration.
                        More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs'
                      properties:
                        action:
                          description: Action to perform based on regex matching.
                            Default is 'replace'
                          type: string
                        modulus:
                          description: Modulus to take of the hash of the source label
                            values.
                          format: int64
                          type: integer
                        regex:
                          description: Regular expression against which the extracted
                            value is matched. defailt is '(.*)'
                          type: string
                        replacement:
                          description: Replacement value against which a regex replace
                            is performed if the regular expression matches. Regex
                            capture groups are available. Default is '$1'
                          type: string
                        separator:
                          description: Separator placed between concatenated source
                            label values. default is ';'.
                          type: string
                        sourceLabels:
                          description: The source labels select values from existing
                            labels. Their content is concatenated using the configured
                            separator and matched against the configured regular expression
                            for the replace, keep, and drop actions.
                          items:
                            type: string
                          type: array
                        targetLabel:
                          description: Label to which the resulting value is written
                            in a replace action. It is mandatory for replace actions.
                            Regex capture groups are available.
                          type: string
                    type: array
                  scheme:
                    description: HTTP scheme to use for scraping.
                    type: string
                  scrapeTimeout:
                    description: Timeout after which the scrape is ended
                    type: string
                  targetPort:
                    anyOf:
                    - type: string
                    - type: integer
                  tlsConfig:
                    description: TLSConfig specifies TLS configuration parameters.
                    properties:
                      caFile:
                        description: The CA cert to use for the targets.
                        type: string
                      certFile:
                        description: The client cert file for the targets.
                        type: string
                      insecureSkipVerify:
                        description: Disable target certificate validation.
                        type: boolean
                      keyFile:
                        description: The client key file for the targets.
                        type: string
                      serverName:
                        description: Used to verify the hostname for the targets.
                        type: string
              type: array
            jobLabel:
              description: The label to use to retrieve the job name from.
              type: string
            namespaceSelector:
              description: NamespaceSelector is a selector for selecting either all
                namespaces or a list of namespaces.
              properties:
                any:
                  description: Boolean describing whether all namespaces are selected
                    in contrast to a list restricting them.
                  type: boolean
                matchNames:
                  description: List of namespace names.
                  items:
                    type: string
                  type: array
            podTargetLabels:
              description: PodTargetLabels transfers labels on the Kubernetes Pod
                onto the target.
              items:
                type: string
              type: array
            sampleLimit:
              description: SampleLimit defines per-scrape limit on number of scraped
                samples that will be accepted.
              format: int64
              type: integer
            selector:
              description: A label selector is a label query over a set of resources.
                The result of matchLabels and matchExpressions are ANDed. An empty
                label selector matches all objects. A null label selector matches
                no objects.
              properties:
                matchExpressions:
                  description: matchExpressions is a list of label selector requirements.
                    The requirements are ANDed.
                  items:
                    description: A label selector requirement is a selector that contains
                      values, a key, and an operator that relates the key and values.
                    properties:
                      key:
                        description: key is the label key that the selector applies
                          to.
                        type: string
                      operator:
                        description: operator represents a key's relationship to a
                          set of values. Valid operators are In, NotIn, Exists and
                          DoesNotExist.
                        type: string
                      values:
                        description: values is an array of string values. If the operator
                          is In or NotIn, the values array must be non-empty. If the
                          operator is Exists or DoesNotExist, the values array must
                          be empty. This array is replaced during a strategic merge
                          patch.
                        items:
                          type: string
                        type: array
                    required:
                    - key
                    - operator
                  type: array
                matchLabels:
                  description: matchLabels is a map of {key,value} pairs. A single
                    {key,value} in the matchLabels map is equivalent to an element
                    of matchExpressions, whose key field is "key", the operator is
                    "In", and the values array contains only "value". The requirements
                    are ANDed.
                  type: object
            targetLabels:
              description: TargetLabels transfers labels on the Kubernetes Service
                onto the target.
              items:
                type: string
              type: array
          required:
          - endpoints
          - selector
  version: v1
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: prometheus-operator
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus-operator
subjects:
- kind: ServiceAccount
  name: prometheus-operator
  namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-operator
rules:
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - '*'
- apiGroups:
  - monitoring.coreos.com
  resources:
  - alertmanagers
  - prometheuses
  - prometheuses/finalizers
  - alertmanagers/finalizers
  - servicemonitors
  - prometheusrules
  verbs:
  - '*'
- apiGroups:
  - apps
  resources:
  - statefulsets
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - configmaps
  - secrets
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - list
  - delete
- apiGroups:
  - ""
  resources:
  - services
  - services/finalizers
  - endpoints
  verbs:
  - get
  - create
  - update
  - delete
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - namespaces
  verbs:
  - get
  - list
  - watch
---
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  labels:
    k8s-app: prometheus-operator
  name: prometheus-operator
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s-app: prometheus-operator
  template:
    metadata:
      labels:
        k8s-app: prometheus-operator
    spec:
      containers:
      - args:
        - --kubelet-service=kube-system/kubelet
        - --logtostderr=true
        - --config-reloader-image=quay.io/coreos/configmap-reload:v0.0.1
        - --prometheus-config-reloader={{ build_image_name('prometheus-config-reloader', 'v0.28.0') }}
        image: {{ build_image_name('prometheus-operator', 'v0.28.0') }}
        name: prometheus-operator
        ports:
        - containerPort: 8080
          name: http
        resources:
          limits:
            cpu: 200m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
      nodeSelector:
        beta.kubernetes.io/os: linux
        node-role.kubernetes.io/infra: ''
      securityContext:
        runAsNonRoot: true
        runAsUser: 65534
      serviceAccountName: prometheus-operator
      tolerations:
      - key: "node-role.kubernetes.io/bootstrap"
        operator: "Exists"
        effect: "NoSchedule"
      - key: "node-role.kubernetes.io/infra"
        operator: "Exists"
        effect: "NoSchedule"
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus-operator
  namespace: monitoring
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    k8s-app: prometheus-operator
  name: prometheus-operator
  namespace: monitoring
spec:
  endpoints:
  - honorLabels: true
    port: http
  selector:
    matchLabels:
      k8s-app: prometheus-operator
---
apiVersion: v1
kind: Service
metadata:
  labels:
    k8s-app: prometheus-operator
  name: prometheus-operator
  namespace: monitoring
spec:
  clusterIP: None
  ports:
  - name: http
    port: 8080
    targetPort: http
  selector:
    k8s-app: prometheus-operator
