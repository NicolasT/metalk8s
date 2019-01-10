.POSIX:

MAKEFLAGS += -r
.DEFAULT_GOAL := default
.DELETE_ON_ERROR:
.SUFFIXES:

KUBERNETES_VERSION = v1.13.1

ETCD_UPSTREAM_IMAGE = k8s.gcr.io/etcd
ETCD_UPSTREAM_TAG = 3.2.24

KUBE_APISERVER_UPSTREAM_IMAGE = k8s.gcr.io/kube-apiserver
KUBE_APISERVER_UPSTREAM_TAG = $(KUBERNETES_VERSION)

KUBE_CONTROLLER_MANAGER_UPSTREAM_IMAGE = k8s.gcr.io/kube-controller-manager
KUBE_CONTROLLER_MANAGER_UPSTREAM_TAG = $(KUBERNETES_VERSION)

KUBE_SCHEDULER_UPSTREAM_IMAGE = k8s.gcr.io/kube-scheduler
KUBE_SCHEDULER_UPSTREAM_TAG = $(KUBERNETES_VERSION)

KUBE_PROXY_UPSTREAM_IMAGE = k8s.gcr.io/kube-proxy
KUBE_PROXY_UPSTREAM_TAG = $(KUBERNETES_VERSION)

PAUSE_UPSTREAM_IMAGE = k8s.gcr.io/pause
PAUSE_UPSTREAM_TAG = 3.1

OUTPUT = _output
OUTPUT_IMAGES = $(OUTPUT)/images

ETCD_IMAGE = $(ETCD_UPSTREAM_IMAGE):$(ETCD_UPSTREAM_TAG)
ETCD_IMAGE_FILE = $(OUTPUT_IMAGES)/etcd-$(ETCD_UPSTREAM_TAG).tgz

KUBE_APISERVER_IMAGE = $(KUBE_APISERVER_UPSTREAM_IMAGE):$(KUBE_APISERVER_UPSTREAM_TAG)
KUBE_APISERVER_IMAGE_FILE = $(OUTPUT_IMAGES)/kube-apiserver-$(KUBE_APISERVER_UPSTREAM_TAG).tgz

KUBE_CONTROLLER_MANAGER_IMAGE = $(KUBE_CONTROLLER_MANAGER_UPSTREAM_IMAGE):$(KUBE_CONTROLLER_MANAGER_UPSTREAM_TAG)
KUBE_CONTROLLER_MANAGER_IMAGE_FILE = $(OUTPUT_IMAGES)/kube-controller-manager-$(KUBE_CONTROLLER_MANAGER_UPSTREAM_TAG).tgz

KUBE_SCHEDULER_IMAGE = $(KUBE_SCHEDULER_UPSTREAM_IMAGE):$(KUBE_SCHEDULER_UPSTREAM_TAG)
KUBE_SCHEDULER_IMAGE_FILE = $(OUTPUT_IMAGES)/kube-scheduler-$(KUBE_SCHEDULER_UPSTREAM_TAG).tgz

KUBE_PROXY_IMAGE = $(KUBE_PROXY_UPSTREAM_IMAGE):$(KUBE_PROXY_UPSTREAM_TAG)
KUBE_PROXY_IMAGE_FILE = $(OUTPUT_IMAGES)/kube-proxy-$(KUBE_PROXY_UPSTREAM_TAG).tgz

PAUSE_IMAGE = $(PAUSE_UPSTREAM_IMAGE):$(PAUSE_UPSTREAM_TAG)
PAUSE_IMAGE_FILE = $(OUTPUT_IMAGES)/pause-$(PAUSE_UPSTREAM_TAG).tgz

BUILT_IMAGES = $(ETCD_IMAGE_FILE) \
	       $(KUBE_APISERVER_IMAGE_FILE) \
	       $(KUBE_CONTROLLER_MANAGER_IMAGE_FILE) \
	       $(KUBE_SCHEDULER_IMAGE_FILE) \
	       $(KUBE_PROXY_IMAGE_FILE) \
	       $(PAUSE_IMAGE_FILE) \

BUILT_PACKAGES =

SKOPEO = $(shell command -v skopeo)

default: all

images: $(OUTPUT_IMAGES) $(BUILT_IMAGES)
.PHONY: images

$(OUTPUT_IMAGES):
	@mkdir -p $@

$(ETCD_IMAGE_FILE):
	$(SKOPEO) copy docker://$(ETCD_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

$(KUBE_APISERVER_IMAGE_FILE):
	$(SKOPEO) copy docker://$(KUBE_APISERVER_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

$(KUBE_CONTROLLER_MANAGER_IMAGE_FILE):
	$(SKOPEO) copy docker://$(KUBE_CONTROLLER_MANAGER_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

$(KUBE_SCHEDULER_IMAGE_FILE):
	$(SKOPEO) copy docker://$(KUBE_SCHEDULER_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

$(KUBE_PROXY_IMAGE_FILE):
	$(SKOPEO) copy docker://$(KUBE_PROXY_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

$(PAUSE_IMAGE_FILE):
	$(SKOPEO) copy docker://$(PAUSE_IMAGE) docker-archive://$(PWD)/$@ || rm -f $@

packages: $(PACKAGES)
.PHONY: packages

all: images packages
.PHONY: all
