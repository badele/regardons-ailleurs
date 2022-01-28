---
title: "Les données de 60 000 reportages des JTs de 20H de France et TF1"
author: "Paul Leclercq"
date: 2022-01-28T08:50:07+02:00
description: "Les JT sont un lieu stratégique d'observation du débat public, analysez les"
type: "post"
image: "images/blog/jt-news-open-data/nombre_reportage_mois_media.png"
categories: 
  - "Open Data"
tags:
  - "JT"
  - "télévision"
---

Dans cette année d'élection, il peut être utile de **rendre public les données de 60 000 reportages des JT de 20H de TF1 et France 2** pour des chercheurs ou des citoyens. La seule condition et de [maitriser](https://jupyter.org/) le format [JSON](https://fr.wikipedia.org/wiki/JavaScript_Object_Notation) et son exploitation.

## Pourquoi les données des JT ?
Le sociologue Jean Baptiste Comby, dans sa thèse ["La question climatique"](https://www.placedeslibraires.fr/livre/9782912107817-la-question-climatique-genese-et-depolitisation-d-un-probleme-public-jean-baptiste-comby/), indique qu'il est "fécond de placer la focale sociologique sur les discours qui circulent au sein des médias généralistes nationaux". Il précise "si les JT sont un lieu stratégique d'observation du débat public, cela ne signifie pas pour autant qu'ils en offrent un reflet représentatif (...) **cependant**, nos observations indiquent que les cadrages du problème récurrents dans les JT sont ceux qui circulent le plus et le mieux dans les autres espaces du débat public"

## Méthodes de récupération de la donnée
En [scrappant](https://en.wikipedia.org/wiki/Data_scraping) les textes des pages des JTs de [TF1 jusqu'en 2016](https://www.tf1info.fr/emission/le-20h-11001/extraits/) et de [France 2 jusqu'en 2013](https://www.francetvinfo.fr/replay-jt/france-2/20-heures/) avec [ce logiciel libre écrit en Scala](https://github.com/polomarcus/television-news-analyser).

Avertissement: Les textes des reportages seulement ont été récoltés, mais pas les voix qui sont parfois plus complètes. Pour aller plus loin, [ce projet permet de récolter les données venant des voix.](https://github.com/magwyz/mediaLexicometer)

## Données
Les données des JTs sont accessibles librement [au format JSON ici](https://github.com/polomarcus/television-news-analyser/tree/main/data-news-json).

Elles possèdent ce format :
* title: String,
* description: String,
* date: Timestamp,
* order: Long - ordre dans le JT de france 2
* presenter: String - exemple David Pujadas
* authors: List[String] - les journalistes
* editor: String, - rédacteur en chef
* editorDeputy: List[String], rédacteur adjoint
* url: String, - url vers le reportage
* urlTvNews: String, - url vers le JT
* containsWordGlobalWarming: Boolean, - si le reportage contient le mot réchauffement ou changement climatique
* media: String - TF1 ou France 2

## Exemple d'exploitation des données
Pour une analyse sur le thème des changements climatiques à paraitre, une base de données SQL, Postgres, et un outil de visualisation, Metabase, ont été utilisées de cette manière : https://github.com/polomarcus/television-news-analyser#requirements

---
Contactez nous pour proposer d'héberger ces données, ou mieux faites le vous même.