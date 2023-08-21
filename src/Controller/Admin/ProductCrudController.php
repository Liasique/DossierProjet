<?php
//Ceci définit l'espace de noms de la classe, 
//ce qui permet de l'organiser au sein de l'application, 
//spécifiquement dans le contexte de l'administration.
namespace App\Controller\Admin;
//Ces lignes importent différentes classes et interfaces nécessaires 
//pour construire et configurer le contrôleur CRUD pour les produits.

//
//Ces lignes importent différentes classes et interfaces nécessaires 
//pour construire et configurer le contrôleur CRUD pour les produits.

use App\Entity\Product;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\SlugField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

//Déclaration de la classe :
// La classe ProductCrudController est déclarée.
// Elle étend AbstractCrudController de EasyAdmin,
// ce qui signifie qu'elle hérite des fonctionnalités de base 
//pour créer un contrôleur CRUD (Create, Read, Update, Delete) dans Symfony avec EasyAdmin.
class ProductCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string //Méthode getEntityFqcn : 
    //Cette méthode retourne le nom complet de la classe (FQCN) de l'entité que ce contrôleur gère, qui est Product.
    {
        return Product::class;
    }

    //Méthode configureFields : 
    //Cette méthode est utilisée pour configurer les champs 
    //qui seront affichés dans le formulaire CRUD pour les produits. 
    //Elle retourne un ensemble de champs.
    public function configureFields(string $pageName): iterable
    {
        // PERSONNALISATION DES ÉLÉMENTS DU MENU AVEC 2 OPTIONS.
        // OPTION 1:
        /*yield FormField::addPanel('Informations du produit')
            ->setIcon('fa fa-info-circle')
            ->setHelp('Renseignez les informations du produit')
            ->setCssClass('col-md-7')
            // On rajoute une classe CSS pour le panel
            ->setCustomOption('class', 'col-md-12')
            ->setCustomOption('style','margin-bottom: 0.5rem')
            ->setCustomOption('data-toggle', 'popover')
            ->setCustomOption('data-content', 'Renseignez les informations du produit')
            ->setColumns(3); // Permets de définir le nombre de colonnes pour les champs qui suivent.

        yield TextField::new('name', 'Nom du produit');
        yield SlugField::new('slug', 'Slug')->setTargetFieldName('name');
        yield ImageField::new('illustration', 'Illustration')
            ->setBasePath('uploads/')
            ->setUploadDir('public/uploads')
            ->setUploadedFileNamePattern('[randomhash].[extension]')
            ->setRequired(false);

        yield TextField::new('subtitle', 'Sous-titre');
        yield AssociationField::new('category', 'Catégorie(s)');

        yield FormField::addPanel('Contenu');
        yield TextEditorField::new('description', 'Description')
            ->setHelp('Renseignez la description du produit');
        yield MoneyField::new('price', 'Preuve')->setCurrency('EUR')->setStoredAsCents(true);
        yield BooleanField::new('isBest', 'Produit à la une');*/


        // OPTION 2:
        //Ceci est la configuration actuellement utilisée pour les champs du formulaire. 
        //Elle définit les champs suivants pour le produit :
        return [
            TextField::new('name', 'Nom du produit'), //Nom du produit.
            SlugField::new('slug', 'Slug')->setTargetFieldName('subtitle'), //Un identifiant unique pour le produit basé sur le sous-titre.
            ImageField::new('illustration', 'Illustration') //Une image représentant le produit.
                ->setBasePath('uploads/')
                ->setUploadDir('public/uploads')
                ->setUploadedFileNamePattern('[randomhash].[extension]')
                ->setRequired(false),
            TextField::new('subtitle', 'Sous-titre'), // Un sous-titre pour le produit.
            AssociationField::new('category', 'Catégories'), //Catégories associées au produit.
            BooleanField::new('isBest', 'Produit à la une'), //Un indicateur pour savoir si le produit est mis en avant.
            BooleanField::new('isStock', 'En stock'), //Un indicateur pour savoir si le produit est en stock.
            MoneyField::new('price', 'Prix')->setCurrency('EUR')->setStoredAsCents(true), // Le prix du produit en euros.
            TextEditorField::new('description', 'Description'), //Une description détaillée du produit.
            TextEditorField::new('quota', 'Quota'), //Un champ pour le quota
        ];
    }
}
