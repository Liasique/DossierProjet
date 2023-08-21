<?php

namespace App\Controller;

use App\Classe\Search;
/* use App\Entity\Category; */
use App\Entity\Product;
use App\Form\SearchType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ProductController extends AbstractController
{
    private EntityManagerInterface $em;

    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }
    #[Route('/nos-produits', name: 'products')]
    public function index(Request $request): Response
    {
        // dd($request->query);
        $search = new Search();
        $form = $this->createForm(SearchType::class, $search);
        $form->handleRequest($request); //analise the request//
        // Si le formulaire est soumis et valide, recherchez les produits avec les critères de recherche
        if ($form->isSubmitted() && $form->isValid()) {
            // dd($request);
            $products = $this->em->getRepository(Product::class)->findWithSearch($search);
        } else {
            // Sinon, récupérez tous les produits
            $products = $this->em->getRepository(Product::class)->findAll();
            $this->redirectToRoute('products');
        }
        // Récupérer les valeurs des critères de recherche depuis la requête
        // $search->string = $request->get('q', '');
        // $search->categories = $request->get('categories', []);
        // $search->productName = $request->get('productName', '');
        // $search->categoryName = $request->get('categoryName', '');
        // // Recherchez à nouveau les produits avec les critères de recherche
        // $products = $this->em->getRepository(Product::class)->findWithSearch($search);
        // Récupérer la valeur du paramètre de recherche depuis la requête
        // $search = $request->query->get('search');

        return $this->render('product/index.html.twig', [
            'products' => $products,
            // 'search' => $search,
            'form' => $form->createView()
        ]);
    }

    #[Route('/produit/{slug}', name: 'product')]
    public function show($slug): Response
    {
        $product = $this->em->getRepository(Product::class)->findOneBySlug($slug);
        $products = $this->em->getRepository(Product::class)->findBy([], ['isBest' => 'ASC'], 6);

        if (!$product) {
            return $this->redirectToRoute('products');
        }

        return $this->render('product/show.html.twig', [
            'product' => $product,
            'products' => $products,
        ]);
    }
}
