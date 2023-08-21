<?php

// Espace de noms pour la classe
namespace App\Controller;

// Utilisation des dépendances nécessaires
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

// Classe AdminController étend la classe AbstractController
class AdminController extends AbstractController
{
    // Route pour la page de connexion de l'administrateur
    #[Route('/admin/login', name: 'admin_login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        // Récupérer la dernière erreur d'authentification et le dernier nom d'utilisateur
        $error = $authenticationUtils->getLastAuthenticationError();
        $lastUsername = $authenticationUtils->getLastUsername();

        // Renvoyer une réponse avec le rendu du template et les paramètres nécessaires
        return $this->render('@EasyAdmin/page/login.html.twig', [
            // Paramètres généralement définis dans les formulaires de connexion Symfony
            'error' => $error,
            'last_username' => $lastUsername,

            // Paramètres OPTIONNELS pour personnaliser le formulaire de connexion

            // Domaine de traduction à utiliser
            'translation_domain' => 'admin',

            // Titre affiché au-dessus du formulaire de connexion
            'page_title' => 'BOUTIQUE - Login',

            // Chaîne utilisée pour générer le jeton CSRF
            'csrf_token_intention' => 'authenticate',

            // URL de redirection après la connexion
            'target_path' => $this->generateUrl('admin'),

            // Libellé affiché pour le champ nom d'utilisateur
            'username_label' => 'olga',

            // Libellé affiché pour le champ mot de passe
            'password_label' => '123456789',

            // Libellé affiché pour le bouton de connexion
            'sign_in_label' => 'Log in',

            // Attribut 'name' HTML de l'élément <input> utilisé pour le champ nom d'utilisateur
            'username_parameter' => 'my_custom_username_field',

            // Attribut 'name' HTML de l'élément <input> utilisé pour le champ mot de passe
            'password_parameter' => 'my_custom_password_field',

            // Activation ou non du lien "Mot de passe oublié ?"
            'forgot_password_enabled' => true,

            // Libellé affiché pour le lien "Mot de passe oublié ?"
            'forgot_password_label' => 'Forgot your password?',

            // Activation ou non de la case à cocher "Se souvenir de moi"
            'remember_me_enabled' => true,

            // Nom du champ formulaire pour "Se souvenir de moi"
            'remember_me_parameter' => 'custom_remember_me_param',

            // Vérification par défaut de la case "Se souvenir de moi"
            'remember_me_checked' => true,

            // Libellé affiché pour la case à cocher "Se souvenir de moi"
            'remember_me_label' => 'Remember me',
        ]);
    }
}
