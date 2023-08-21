<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PagesController extends AbstractController
{
    #[Route('/about', name: 'about')]
    public function about(): Response
    {
        return $this->render('_pages/about.html.twig', [
            'controller_name' => 'PagesController',
        ]);
    }

    #[Route('/faq', name: 'faq')]
    public function faq(): Response
    {
        return $this->render('_pages/faq.html.twig', [
            
        ]);
    }

    #[Route('/contacts', name: 'contacts')]
    public function contacts(): Response
    {
        return $this->render('_pages/contacts.html.twig', [
            
        ]);
    }

    #[Route('/privacy', name: 'privacy')]
    public function privacy(): Response
    {
        return $this->render('_pages/privacy.html.twig', [
            
        ]);
    }

    #[Route('/terms', name: 'terms')]
    public function terms(): Response
    {
        return $this->render('_pages/terms.html.twig', [
            
        ]);
    }
}
