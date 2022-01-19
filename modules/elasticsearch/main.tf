terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.7"
    }
  }
}

// Deploy elasticsearch cluster
resource "kubernetes_manifest" "elasticsearch_quickstart" {
  manifest = {
    "apiVersion" = "elasticsearch.k8s.elastic.co/v1"
    "kind" = "Elasticsearch"
    "metadata" = {
      "name" = "quickstart"
    }
    "spec" = {
      "nodeSets" = [
        {
          "config" = {
            "node.store.allow_mmap" = false
          }
          "count" = 1
          "name" = "default"
        },
      ]
      "version" = "7.16.2"
    }
  }
}

// deploy Kibana
resource "kubernetes_manifest" "kibana_quickstart" {
  manifest = {
    "apiVersion" = "kibana.k8s.elastic.co/v1"
    "kind" = "Kibana"
    "metadata" = {
      "name" = "quickstart"
    }
    "spec" = {
      "count" = 1
      "elasticsearchRef" = {
        "name" = "quickstart"
      }
      "version" = "7.16.2"
    }
  }
}

// get the elasticsearch service, so we can find the cluster IP for it.
data "kubernetes_service" "elasticsearch_data" {
  metadata {
    name = "quickstart-es-http"
  }
}

// get the kibana service, so we can find the cluster IP for it.
data "kubernetes_service" "kibana_data" {
  metadata {
    name = "quickstart-kb-http"
  }
}