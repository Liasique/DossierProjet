<?php

// Espace de noms pour la classe
namespace App\Classe;

// Utilisation des dépendances nécessaires
use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class Cart
{
    // Attributs pour stocker la session et le gestionnaire d'entités
    private SessionInterface $session;
    private EntityManagerInterface $em;

    // Constructeur pour injecter les dépendances
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->session = $session;
        $this->em = $em;
    }

    // Méthode pour ajouter un produit au panier
    public function add($id): void
    {
        // On récupère le panier dans la session, sinon on initialise un tableau vide
        $cart = $this->session->get('cart', []);

        // Si le produit existe déjà dans le panier, on incrémente sa quantité
        if (!empty($cart[$id])) {
            $cart[$id]++; 
        } else {
            // Sinon, on l'ajoute au panier avec une quantité de 1
            $cart[$id] = 1;
        }
        // On met à jour le panier dans la session
        $this->session->set('cart', $cart);
    }

    // Méthode pour récupérer le panier
    public function get()
    {
        return $this->session->get('cart');
    }

    // Méthode pour supprimer le panier
    public function remove()
    {
        return $this->session->remove('cart');
    }

    // Méthode pour supprimer un produit du panier
    public function delete($id)
    {
        // On récupère le panier dans la session
        $cart = $this->session->get('cart', []);
        // On supprime le produit du panier
        unset($cart[$id]);
        // On met à jour le panier dans la session
        return $this->session->set('cart', $cart);
    }

    // Méthode pour diminuer la quantité d'un produit dans le panier
    public function decrease($id)
    {
        // On récupère le panier dans la session
        $cart = $this->session->get('cart', []);

        // Si la quantité du produit est supérieure à 1
        if ($cart[$id] > 1) {
            // On décrémente la quantité
            $cart[$id]--;
        } else {
            // Sinon, on supprime le produit du panier
            unset($cart[$id]);
        }

        // On met à jour le panier dans la session
        return $this->session->set('cart', $cart);
    }

    // Méthode pour récupérer le panier complet avec les objets produits
    

// Méthode pour récupérer le panier complet avec les objets produits
public function getFull(): array
{
    $cartComplete = [];

    // Si la session cart existe
    if ($this->get()) {
        // Pour chaque produit dans la session cart
        foreach ($this->get() as $id => $quantity) {
            // On récupère l'objet produit
            $product_object = $this->em->getRepository(Product::class)->findOneById($id);

            // Si le produit n'existe pas, on le supprime du panier et on passe à l'itération suivante
            if (!$product_object) {
                $this->delete($id);
                continue;
            }

            // On ajoute le produit et sa quantité au tableau cartComplete
            $cartComplete[] = [
                'product' => $product_object,
                'quantity' => $quantity
            ];
        }
    }

    // On retourne le tableau cartComplete
    return $cartComplete;
}

// Méthode pour gérer les produits favoris
public function favorites($id) {
    // Récupère les produits favoris dans la session, sinon initialise un tableau vide
    $favorites = $this->session->get('favorites', []);

    // Ajoute le produit en favori
    $favorites[$id] = true;

    // Enregistre les produits favoris dans la session
    $this->session->set('favorites', $favorites);
}

}