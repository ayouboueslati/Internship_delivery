# Utilisez une image de base qui inclut Flutter préinstallé
FROM cirrusci/flutter:latest

# Copiez les fichiers de votre application dans le conteneur
COPY . /app

# Définissez le répertoire de travail
WORKDIR /app

# Créez un utilisateur non privilégié et configurez les permissions
RUN adduser --disabled-password --gecos "" appuser && \
    chown -R appuser:appuser /sdks/flutter

# Basculez vers l'utilisateur non privilégié
USER appuser

# Configurez Git pour autoriser l'accès au répertoire /sdks/flutter
RUN git config --global --add safe.directory /sdks/flutter

# Exécutez les commandes Flutter en tant qu'utilisateur non privilégié
RUN flutter pub get
RUN flutter build apk

# Exposez le port si votre application en a besoin
# EXPOSE 8080

# Commande pour exécuter l'application (remplacez par la commande Flutter appropriée)
CMD ["flutter", "run"]
