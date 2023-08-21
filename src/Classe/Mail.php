<?php
// Importation des classes et interfaces nécessaires

namespace App\Classe;

use Mailjet\Client;
use Mailjet\Resources;
use Psr\Log\LoggerInterface;

class Mail
{
    // Constantes pour l'expéditeur de l'email
    const FROM_EMAIL = 'olgalukianets7@gmail.com';
    const FROM_NAME = 'THE SWANKY SACK';
    const TEMPLATE_ID = 4656877;

    // Attribut pour le journal (logger)
    private LoggerInterface $logger;

    // Constructeur de la classe qui initialise le journal (logger)
    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    // Méthode pour envoyer un email
    public function send(string $to_email, string $to_name, string $subject, string $content): void
    {
        // Création d'un nouveau client Mailjet avec la clé API, la clé secrète et les options
        $mj = new Client(MailConfig::getApiKey(), MailConfig::getApiSecretKey(), true, ['version' => 'v3.1', 'timeout' => 30]);

        // Préparation du contenu de l'email
        $body = [
            'Messages' => [
                [
                    'From' => [
                        'Email' => self::FROM_EMAIL,
                        'Name' => self::FROM_NAME
                    ],
                    'To' => [
                        [
                            'Email' => $to_email,
                            'Name' => $to_name
                        ]
                    ],
                    'TemplateID' => self::TEMPLATE_ID,
                    'TemplateLanguage' => true,
                    'Subject' => $subject,
                    'Variables' => [
                        'content' => $content,
                        
                    ]
                ]
            ]
        ];

        try {
            // Envoi de l'email en utilisant l'API Mailjet
            $response = $mj->post(Resources::$Email, ['body' => $body]);
            $response->success();

            // Enregistrement d'un message de réussite dans le journal
            $this->logger->info('Email envoyé', ['to_email' => $to_email, 'subject' => $subject]);
        } catch (\Exception $e) {
            // Enregistrement d'un message d'erreur dans le journal en cas d'exception
            $this->logger->error('Error sending email', ['error' => $e->getMessage()]);
        }
    }
}
