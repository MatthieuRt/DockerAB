# Utiliser l'image de base atmoz/sftp
FROM atmoz/sftp

# Créer un utilisateur avec le mot de passe et le UID (ici 1001)
# Changez "foo:pass" pour votre nom d'utilisateur et mot de passe souhaités
# Si vous n'avez pas de dossier spécifique, l'utilisateur utilisera son répertoire par défaut
ENV SFTP_USERS foo:pass:1001

# Exposer le port 22
EXPOSE 2222

# Commande par défaut pour démarrer le serveur SFTP
CMD ["foo:pass"]