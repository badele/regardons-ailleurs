---
title: "Exercice d'étude des incivilités urbaines"
author: "Bruno Adelé"
date: 2021-11-28T14:46:10+06:00
description: "Etude des incivilités en ville"
type: "post"
image: "/images/blog/exercice-etude-incivilite-urbaine/main-image.png"
categories: 
  - "Pays"
tags:
  - "Analyse"
  - "Urbanisme"
output: 
    md_document:
      preserve_yaml: true
      fig_caption: yes
---



### Comment mesurer l'incivilité urbaine

Suite à un mouvement cycliste sur Montpellier, [Quentin Hess](https://twitter.com/kentiss34) a dévélopé l'application [Vigilo](https://vigilo.city/fr/). Celle ci permet d'apporter des observations sur les villes en tant que piéton ou cycliste. 

> **NOTE**: Les categories inferieures à **2.0%** sont groupées dans **Autre** 

Au **17 décembre 2021** le panel est composé de **230** villes réparties sur **19** instances. ce panel comprend **31544** observations.

#### Les villes du panel



[![categories](/images/blog/exercice-etude-incivilite-urbaine/instance_creation.png)](/images/blog/exercice-etude-incivilite-urbaine/instance_creation_zoom.png)

[![categories](/images/blog/exercice-etude-incivilite-urbaine/total_observations.png)](/images/blog/exercice-etude-incivilite-urbaine/total_observations_zoom.png)


<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Instance </th>
   <th style="text-align:right;"> Nb villes </th>
   <th style="text-align:right;"> Nb observations </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Aix Marseille Provence Metropole </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 1933 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Amiens </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bordeaux Métropole </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 462 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Brest </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 386 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Isère (APIE) </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 155 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Montpellier </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 7865 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Nantes Métropole </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 17662 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Paris-Saclay </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 1115 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Périgueux Agglo </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Saint-Brieuc Armor Agglomération </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 250 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Strasbourg </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 434 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Troyes Agglomération </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 517 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [ Autres instances ] </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 231 </td>
  </tr>
</tbody>
</table>


### Répartitions des catégories





Au niveau national, sur **31544** observations, nous observons que c'est la catégorie **"Véhicule ou objet gênant"** qui arrive en tête avec **67.9%**

[![categories](/images/blog/exercice-etude-incivilite-urbaine/repartition_categories.png)](/images/blog/exercice-etude-incivilite-urbaine/repartition_categories_zoom.png)


<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Categorie </th>
   <th style="text-align:right;"> Nb observations </th>
   <th style="text-align:left;"> Pourcentage </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Véhicule ou objet gênant </td>
   <td style="text-align:right;"> 21422 </td>
   <td style="text-align:left;"> 67.9% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Incivilité récurrente sur la route </td>
   <td style="text-align:right;"> 3190 </td>
   <td style="text-align:left;"> 10.1% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Aménagement mal conçu </td>
   <td style="text-align:right;"> 2750 </td>
   <td style="text-align:left;"> 8.7% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Défaut d'entretien </td>
   <td style="text-align:right;"> 1577 </td>
   <td style="text-align:left;"> 5.0% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> [ Autre ] </td>
   <td style="text-align:right;"> 990 </td>
   <td style="text-align:left;"> 3.1% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Absence d'aménagement </td>
   <td style="text-align:right;"> 863 </td>
   <td style="text-align:left;"> 2.7% </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Signalisation, marquage </td>
   <td style="text-align:right;"> 752 </td>
   <td style="text-align:left;"> 2.4% </td>
  </tr>
</tbody>
</table>


### Palmares des villes avec le plus fort taux d'incivilité urbaine



[![pourcentage categorie](/images/blog/exercice-etude-incivilite-urbaine/percent_summary.png)](/images/blog/exercice-etude-incivilite-urbaine/percent_summary_zoom.png)




<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> # </th>
   <th style="text-align:left;"> Instance </th>
   <th style="text-align:left;"> Véhicule ou objet gênant </th>
   <th style="text-align:left;"> Incivilité récurrente sur la route </th>
   <th style="text-align:left;"> Total incivilités </th>
   <th style="text-align:right;"> Total Obs </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Troyes Agglomération </td>
   <td style="text-align:left;"> 82.01% </td>
   <td style="text-align:left;"> 5.61% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 87.62% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 517 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> Nantes Métropole </td>
   <td style="text-align:left;"> 71.01% </td>
   <td style="text-align:left;"> 12.90% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 83.91% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 17662 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> Aix Marseille Provence Metropole </td>
   <td style="text-align:left;"> 75.53% </td>
   <td style="text-align:left;"> 4.50% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 80.03% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 1933 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Montpellier </td>
   <td style="text-align:left;"> 69.96% </td>
   <td style="text-align:left;"> 5.01% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 74.97% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 7865 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> Amiens </td>
   <td style="text-align:left;"> 52.52% </td>
   <td style="text-align:left;"> 21.10% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 73.62% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 417 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> Bordeaux Métropole </td>
   <td style="text-align:left;"> 69.91% </td>
   <td style="text-align:left;"> 2.81% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 72.73% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 462 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Strasbourg </td>
   <td style="text-align:left;"> 42.40% </td>
   <td style="text-align:left;"> 13.59% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 55.99% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 434 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> Paris-Saclay </td>
   <td style="text-align:left;"> 39.73% </td>
   <td style="text-align:left;"> 16.14% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 55.87% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 1115 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> Saint-Brieuc Armor Agglomération </td>
   <td style="text-align:left;"> 46.40% </td>
   <td style="text-align:left;"> 6.80% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 53.20% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 250 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> Brest </td>
   <td style="text-align:left;"> 42.75% </td>
   <td style="text-align:left;"> 6.48% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 49.22% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 386 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> Périgueux Agglo </td>
   <td style="text-align:left;"> 11.97% </td>
   <td style="text-align:left;"> 5.13% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 17.09% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 117 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> Isère (APIE) </td>
   <td style="text-align:left;"> 10.32% </td>
   <td style="text-align:left;"> 3.87% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 14.19% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 155 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> [ Autres instances ] </td>
   <td style="text-align:left;"> 6.49% </td>
   <td style="text-align:left;"> 3.03% </td>
   <td style="text-align:left;font-weight: bold;background-color: #e5e5e5 !important;"> 9.52% </td>
   <td style="text-align:right;font-weight: bold;background-color: #e5e5e5 !important;"> 231 </td>
  </tr>
</tbody>
</table>



[Visualiser le tableau en grand format](/images/blog/exercice-etude-incivilite-urbaine/palmares_incivilite.png)


