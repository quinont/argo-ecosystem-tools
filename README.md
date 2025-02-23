# argo-ecosystem-tools

Esto es una imagen que tiene las siguientes herramientas:
- kubectl
- jq
- yq
- argo cd cli
- argo rollout cli
- git


## Como hacer el build?

Instale docker buildx

Corra el siguiente comando:

```
docker buildx build --platform linux/amd64,linux/arm64 -t quinont/argo-ecosystem-tools:2 -t quinont/argo-ecosystem-tools:latest --push .
```

## Como ocuparlo?

Corra el siguiente comando:

```
docker run --rm -it  quinont/argo-ecosystem-tools:2
```


# TODO para el futuro

- sumcheck sobre los archivos para validarlos.
- Armado de pipeline para buildear mas facil.
- Disminuir tamaño de imagen
