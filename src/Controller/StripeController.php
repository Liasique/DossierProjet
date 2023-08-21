<?php

namespace App\Controller;

use App\Classe\Cart;
use App\Entity\Order;
use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use Stripe\Checkout\Session;
use Stripe\Stripe;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class StripeController extends AbstractController
{
    // Route pour créer une session Stripe de paiement
    #[Route('/commande/create-session/{ref}', name: 'stripe_create_session')]
    public function index(EntityManagerInterface $em, $ref): JsonResponse
    {
        // Adresse de base de l'application
        $YOUR_DOMAIN = 'http://127.0.0.1:8000';
        // Tableau contenant les produits à envoyer à Stripe
        $productsForStripe = [];
        // Récupération de la commande en cours à partir de la référence    
        $order = $em->getRepository(Order::class)->findOneByRef(['ref' => $ref]);

        // Si la commande n'existe pas, on renvoie une erreur
        if (!$order) {
            new JsonResponse(['error' => 'order']);
        }
        // Pour chaque produit de la commande, on crée un élément pour l'envoyer à Stripe

        foreach ($order->getOrderDetails()->getValues() as $product) {
            // Récupération de l'objet Product correspondant au produit de la commande

            $product_object = $em->getRepository(Product::class)->findOneByName(['name' => $product->getProduct()]);
            // Création de l'élément pour l'envoyer à Stripe

            $productsForStripe[] = [
                'price_data' => [
                    'currency' => 'eur',
                    'unit_amount' => $product->getPrice(),
                    'product_data' => [
                        'name' => $product->getProduct(),
                        'images' => [$YOUR_DOMAIN . "/uploads/" . $product_object->getIllustration()],
                    ],
                ],
                'quantity' => $product->getQuantity(),
            ];
        }
        // Ajout du transporteur à la commande
        $productsForStripe[] = [
            'price_data' => [
                'currency' => 'eur',
                'unit_amount' => $order->getCarrierPrice(),
                'product_data' => [
                    'name' => $order->getCarrierName(),
                    'images' => [$YOUR_DOMAIN],
                ],
            ],
            'quantity' => 1,
        ];
        // Configuration de l'API Stripe avec la clé secrète
        Stripe::setApiKey('sk_test_51Mg7IzKxeqnMlT95DrhambItPnSdAUQV6MoAl5AH1Tl6zZ3HM0eIZNNq4v6dGFmFKbaxIHytVcVttx6MnSyjwKSS00x64Tcp7T');
        // Création de la session Stripe
        $checkoutSession = Session::create([
            'customer_email' => $this->getUser()->getEmail(),
            'payment_method_types' => ['card'],
            'line_items' => $productsForStripe,
            'mode' => 'payment',
            'success_url' => $YOUR_DOMAIN . '/commande/success/{CHECKOUT_SESSION_ID}',
            'cancel_url' => $YOUR_DOMAIN . '/commande/failed/{CHECKOUT_SESSION_ID}',
        ]);
        // Enregistrement de l'id de la session Stripe dans la commande

        $order->setStripeSessionId($checkoutSession->id); // On enregistre l'id de la session Stripe dans notre commande

        $em->flush(); // On enregistre en base de données

        return new JsonResponse(['id' => $checkoutSession->id], 200, []); // On retourne l'id de la session Stripe au format JSON

    }
}
