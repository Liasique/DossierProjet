<?php

// Déclaration de l'espace de noms
namespace App\Classe;

use App\Entity\Order;
use Psr\Log\LoggerInterface;

// Création de la classe StatePreparationEmailService
class StatePreparationEmailService
{
    // Attributs pour stocker les instances du logger et du service d'envoi d'emails
    private LoggerInterface $logger;
    private Mail $mail;

    // Constructeur pour initialiser les instances du logger et du service d'envoi d'emails
    public function __construct(LoggerInterface $logger, Mail $mail)
    {
        $this->logger = $logger;
        $this->mail = $mail;
    }

    // Méthode pour envoyer un email de confirmation de préparation d'une commande
    public function sendOrderPreparationEmail(Order $order): void
    {
        // Récupération de l'utilisateur et de l'ID de commande
        $user = $order->getUser();
        $orderId = $order->getRef();

        // Sujet de l'email
        $subject = "État de votre commande n°$orderId";

        // Contenu de l'email
        $content = "Bonjour {$user->getFirstName()} {$user->getLastName()},<br>";
        $content .= "Nous souhaitons vous informer que votre commande n°$orderId est actuellement en cours de préparation.<br>";
        $content .= "Nous mettons tout en œuvre pour que votre commande vous parvienne dans les délais impartis et en parfait état.<br><br>";
        $content .= "Si vous avez des questions ou des préoccupations concernant votre commande, n'hésitez pas à nous contacter à l'adresse e-mail ou au numéro de téléphone figurant sur notre site web.<br><br>";
        $content .= "Nous vous remercions pour votre confiance et votre fidélité.";

        // Envoi de l'email
        $this->mail->send($user->getEmail(), "{$user->getFirstName()} {$user->getLastName()}", $subject, $content);

        // Log de l'envoi de l'email
        $this->logger->info('Email de confirmation envoyé', ['to_email' => $user->getEmail()]);
    }
}
