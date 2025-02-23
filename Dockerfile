FROM alpine:3.21

ARG TARGETARCH

# Versiones configurables
ARG KUBECTL_VERSION="1.32.2"
ARG ARGOCD_VERSION="2.14.2"
ARG ARGOROLLOUTS_VERSION="1.8.0"
ARG YQ_VERSION="4.45.1"

# Instalación de paquetes base
RUN apk add --no-cache \
    curl \
    git \
    jq \
    openssh-client

# Instalar yq
RUN curl -sSLO "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_${TARGETARCH}" && \
    install -o root -g root -m 0755 yq_linux_${TARGETARCH} /usr/local/bin/yq && \
    rm yq_linux_${TARGETARCH}

# Instalar kubectl con verificación de checksum
RUN curl -sSLO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
    curl -sSLO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c - && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl kubectl.sha256

# Instalar Argo CD CLI
RUN curl -sSLO "https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-${TARGETARCH}" && \
    install -o root -g root -m 0755 argocd-linux-${TARGETARCH} /usr/local/bin/argocd && \
    rm argocd-linux-${TARGETARCH}

# Instalar Argo Rollouts CLI
RUN curl -sSLO "https://github.com/argoproj/argo-rollouts/releases/download/v${ARGOROLLOUTS_VERSION}/kubectl-argo-rollouts-linux-${TARGETARCH}" && \
    install -o root -g root -m 0755 kubectl-argo-rollouts-linux-${TARGETARCH} /usr/local/bin/kubectl-argo-rollouts && \
    rm kubectl-argo-rollouts-linux-${TARGETARCH}

# Directorio de trabajo por defecto
WORKDIR /workspace
