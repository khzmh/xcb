#!/bin/bash

# --- SESUAIKAN VARIABEL DI BAWAH INI ---
IMAGE_NAME="xcb" # Contoh: webappku, my-custom-app
IMAGE_TAG="latest" # Contoh: latest, v1.0, development
# DOCKERFILE_PATH="." # Path ke direktori yang berisi Dockerfile. Defaultnya adalah direktori saat ini.
                     # Jika Dockerfile Anda bernama lain (misal: Dockerfile.dev), ubah menjadi:
                     # DOCKERFILE_PATH="-f Dockerfile.dev ."
# BUILD_ARGS="" # Argumen build tambahan, contoh: "--build-arg USER_ID=$(id -u) --build-arg VERSION=1.2" (Opsional)
# NO_CACHE_OPTION="" # Jika ingin build tanpa cache, isi dengan "--no-cache" (Opsional)
# --- BATAS PENYESUAIAN ---

# Set default Dockerfile path jika tidak diisi
if [ -z "$DOCKERFILE_PATH" ]; then
  DOCKERFILE_PATH="."
fi

# Periksa apakah nama image diisi
if [ -z "$IMAGE_NAME" ]; then
  echo "Kesalahan: IMAGE_NAME belum diatur dalam script."
  echo "Silakan edit script dan isi nama untuk image yang akan di-build."
  exit 1
fi

# Periksa apakah tag image diisi
if [ -z "$IMAGE_TAG" ]; then
  echo "Kesalahan: IMAGE_TAG belum diatur dalam script."
  echo "Silakan edit script dan isi tag untuk image yang akan di-build."
  exit 1
fi

FULL_IMAGE_NAME="$IMAGE_NAME:$IMAGE_TAG"

echo "Memulai proses build untuk image: $FULL_IMAGE_NAME"
echo "Menggunakan Dockerfile/konteks di path: $DOCKERFILE_PATH"
if [ ! -z "$BUILD_ARGS" ]; then
  echo "Dengan build arguments: $BUILD_ARGS"
fi
if [ ! -z "$NO_CACHE_OPTION" ]; then
  echo "Opsi tanpa cache diaktifkan."
fi
echo "-----------------------------------------------------"

# Perintah docker build
# -t : tag image dengan format nama:tag
# $DOCKERFILE_PATH : path ke Dockerfile atau konteks build
COMMAND="sudo docker buildx build -t $FULL_IMAGE_NAME"

if [ ! -z "$BUILD_ARGS" ]; then
  COMMAND="$COMMAND $BUILD_ARGS"
fi

if [ ! -z "$NO_CACHE_OPTION" ]; then
  COMMAND="$COMMAND $NO_CACHE_OPTION"
fi

COMMAND="$COMMAND $DOCKERFILE_PATH"

echo "Menjalankan perintah: $COMMAND"
echo "-----------------------------------------------------"

# Eksekusi perintah build
$COMMAND

# Periksa apakah build berhasil
if [ $? -eq 0 ]; then
  echo "-----------------------------------------------------"
  echo "Build image $FULL_IMAGE_NAME berhasil!"
  echo "Anda bisa melihat image dengan perintah: sudo docker images | grep $IMAGE_NAME"
else
  echo "-----------------------------------------------------"
  echo "Build image $FULL_IMAGE_NAME gagal."
fi

echo "Script build selesai."
