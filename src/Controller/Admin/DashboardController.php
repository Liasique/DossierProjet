<?php

namespace App\Controller\Admin;

use App\Entity\User;
use App\Entity\Order;
use App\Entity\Address;
use App\Entity\Carrier;
use App\Entity\Invoice;
use App\Entity\Product;
use App\Entity\Carousel;
use App\Entity\Category;
use Symfony\Component\HttpFoundation\Response;
use App\Controller\Admin\ProductCrudController;
use Symfony\Component\Routing\Annotation\Route;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use Symfony\Component\HttpFoundation\RedirectResponse;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;

class DashboardController extends AbstractDashboardController
// Ce code est une classe PHP définissant un contrôleur Symfony pour le tableau de bord de l'administrateur.
//  Elle est située dans l'espace de noms App\Controller\Admin.
{
    #[Route('/admin', name: 'admin')]
    // Cette méthode index() est annotée avec l'attribut #[Route] qui indique que cette méthode répond à l'URL '/admin' et est nommée 'admin'.
    //  Lorsque cette route est accédée, elle redirige vers le contrôleur ProductCrudController de EasyAdmin.
    public function index(): Response
    {
        $adminUrlGenerator = $this->container->get(AdminUrlGenerator::class);
        return $this->redirect($adminUrlGenerator->setController(ProductCrudController::class)->generateUrl());
    }

    // Cette méthode impersonate() permet à un utilisateur avec le rôle d'administrateur de prendre l'identité d'un autre utilisateur. 
    // Cependant, avant de pouvoir l'utiliser, l'utilisateur doit avoir le rôle 'ROLE_ALLOWED_TO_SWITCH' et 'ROLE_ADMIN'. 
    // Sinon, une exception AccessDeniedException est levée. L'utilisateur courant est ensuite basculé vers l'utilisateur spécifié. 
    // Si l'utilisateur courant est toujours un administrateur après le basculement, il est redirigé vers la route 'admin'. 
    // Sinon, il est redirigé vers la route 'home'.
    public function impersonate(User $user): RedirectResponse
    {
        $this->denyAccessUnlessGranted('ROLE_ALLOWED_TO_SWITCH');

        if (!$this->isGranted('ROLE_ADMIN')) {
            throw new AccessDeniedException();
        }

        $token = new UsernamePasswordToken($user, null, (array)'main', $user->getRoles());
        $this->get('security.token_storage')->setToken($token);
        $this->get('session')->set('_security_main', serialize($token));

        // Rediriger l'utilisateur vers une page de son choix
        if ($this->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('admin');
            //return new RedirectResponse($this->generateUrl('admin/admin_dashboard'));
        } else {
            return new RedirectResponse($this->generateUrl('home'));
        }
    }


    // Cette méthode configureDashboard() configure le tableau de bord de l'administration. 
    // Elle utilise la classe Dashboard de EasyAdminBundle pour définir des options telles que le titre du tableau de bord, 
    // le chemin vers l'icône de favicon, l'affichage maximisé du contenu et le domaine de traduction 
    // utilisé pour les textes du tableau de bord.

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('The Swanky Sack')
            ->setFaviconPath('favicon.ico')
            ->renderContentMaximized()
            ->setTranslationDomain('admin');
    }


    // Cette méthode configureMenuItems() configure les éléments de menu du tableau de bord de l'administration. 
    // Elle utilise la classe MenuItem de EasyAdminBundle pour définir différents liens et sections du menu. 
    // Chaque élément de menu est créé à l'aide de la méthode yield, ce qui permet de retourner un itérable d'éléments de menu.

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToDashboard('Dashboard', 'fas fa-tachometer-alt')
            ->setCssClass('text-uppercase font-weight-bold text-info');;
        yield MenuItem::linkToRoute('Aller à la Boutique', 'fa fa-home', 'products')
            ->setCssClass('text-uppercase font-weight-bold text-info');;

        yield MenuItem::section('Gestion des articles');
        yield MenuItem::linkToCrud('Produits', 'fas fa-tags', Product::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        yield MenuItem::linkToCrud('Catégories', 'fas fa-list', Category::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');

        yield MenuItem::section('Gestion des users');
        yield MenuItem::linkToCrud('User', 'fas fa-users', User::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        // ->setPermission('ROLE_ADMIN');

        yield MenuItem::linkToCrud('Adresse',  'fas fa-map-marker-alt', Address::class)
            ->setCssClass('text-uppercase font-weight-bold text-info');

        yield MenuItem::section('Gestion des commandes');
        yield MenuItem::linkToCrud('Commandes', 'fas fa-shopping-cart', Order::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        // ->setPermission('ROLE_ADMIN');

        yield MenuItem::linkToCrud('Transporteurs', 'fas fa-truck', Carrier::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        // ->setPermission('ROLE_ADMIN');

        yield MenuItem::section('Gestion des factures');
        yield MenuItem::linkToCrud('Factures', 'fas fa-file-invoice', Invoice::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        // ->setPermission('ROLE_ADMIN');

        yield MenuItem::section('Gestion des carousels');
        yield MenuItem::linkToCrud('Carousel', 'fas fa-images', Carousel::class)
            ->setDefaultSort(['id' => 'DESC'])
            ->setCssClass('text-uppercase font-weight-bold text-info');
        // ->setPermission('ROLE_ADMIN');
    }




    // Cette méthode configureActions() configure les actions disponibles pour les entités affichées dans
    //  les pages d'index du CRUD (Create, Read, Update, Delete). Elle utilise la classe Actions de EasyAdminBundle 
    //  pour définir différentes actions et leurs options.

    // Ici, les actions de création, d'édition et de suppression sont mises à jour pour modifier leur icône, 
    // leur libellé, leur classe CSS et leurs attributs HTML.

    // De plus, une action de détail est ajoutée pour afficher les détails d'une entité dans la page d'index.


    public function configureActions(): Actions
    {
        $actions = parent::configureActions();

        $actions->update(Crud::PAGE_INDEX, Action::NEW, function (Action $action) {
            return $action
                ->setIcon('fas fa-plus')
                ->setLabel('AJOUTER')
                ->setCssClass('btn btn-info btn-sm text-white')
                ->setHtmlAttributes(['title' => 'Ajouter un produit']);
        });

        $actions->update(Crud::PAGE_INDEX, Action::EDIT, function (Action $action) {
            return $action
                ->setIcon('fas fa-pen')
                ->setLabel('ÉDITER')
                ->setCssClass('btn btn-info btn-sm text-white')
                ->setHtmlAttributes(['title' => 'Édit un produit']);
        });

        $actions->update(Crud::PAGE_INDEX, Action::DELETE, function (Action $action) {
            return $action
                ->setIcon('fas fa-trash-alt')
                ->setLabel('SUPPRIMER')
                ->setCssClass('btn btn-info btn-sm text-white')
                ->setHtmlAttributes(['title' => 'Supprimer un produit']);
        });

        $actions->add(Crud::PAGE_INDEX, Action::DETAIL);

        return $actions;
    }
}
