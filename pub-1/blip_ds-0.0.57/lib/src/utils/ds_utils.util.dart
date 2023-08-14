import '../models/ds_country.model.dart';

/// All utility constants that are used by this Design System.
abstract class DSUtils {
  static const packageName = 'blip_ds';
  static const defaultAnimationDuration = Duration(
    milliseconds: 300,
  );
  static const bubbleMinSize = 240.0;
  static const bubbleMaxSize = 480.0;

  static const countriesList = <DSCountry>[
    DSCountry(
      code: '+55',
      name: 'Brasil',
      flag: 'brazil_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Estados Unidos',
      flag: 'united_states_flag',
    ),
    DSCountry(
      code: '+93',
      name: 'Afeganistão',
      flag: 'afghanistan_flag',
    ),
    DSCountry(
      code: '+27',
      name: 'África do Sul',
      flag: 'south_africa_flag',
    ),
    DSCountry(
      code: '+355',
      name: 'Albânia',
      flag: 'albania_flag',
    ),
    DSCountry(
      code: '+49',
      name: 'Alemanha',
      flag: 'germany_flag',
    ),
    DSCountry(
      code: '+376',
      name: 'Andorra',
      flag: 'andorra_flag',
    ),
    DSCountry(
      code: '+244',
      name: 'Angola',
      flag: 'angola_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Anguilla',
      flag: 'anguilla_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Antígua e Barbuda',
      flag: 'antigua_and_barbuda_flag',
    ),
    DSCountry(
      code: '+966',
      name: 'Arábia Saudita',
      flag: 'saudi_arabia_flag',
    ),
    DSCountry(
      code: '+213',
      name: 'Argélia',
      flag: 'algeria_flag',
    ),
    DSCountry(
      code: '+54',
      name: 'Argentina',
      flag: 'argentina_flag',
    ),
    DSCountry(
      code: '+374',
      name: 'Armênia',
      flag: 'armenia_flag',
    ),
    DSCountry(
      code: '+297',
      name: 'Aruba',
      flag: 'aruba_flag',
    ),
    DSCountry(
      code: '+61',
      name: 'Austrália',
      flag: 'australia_flag',
    ),
    DSCountry(
      code: '+43',
      name: 'Áustria',
      flag: 'austria_flag',
    ),
    DSCountry(
      code: '+994',
      name: 'Azerbaijão',
      flag: 'azerbaijan_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Bahamas',
      flag: 'bahamas_flag',
    ),
    DSCountry(
      code: '+880',
      name: 'Bangladesh',
      flag: 'bangladesh_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Barbados',
      flag: 'barbados_flag',
    ),
    DSCountry(
      code: '+973',
      name: 'Bahrein',
      flag: 'bahrain_flag',
    ),
    DSCountry(
      code: '+32',
      name: 'Bélgica',
      flag: 'belgium_flag',
    ),
    DSCountry(
      code: '+501',
      name: 'Belize',
      flag: 'belize_flag',
    ),
    DSCountry(
      code: '+229',
      name: 'Benim',
      flag: 'benin_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Bermudas',
      flag: 'bermuda_flag',
    ),
    DSCountry(
      code: '+375',
      name: 'Bielorrússia',
      flag: 'belarus_flag',
    ),
    DSCountry(
      code: '+591',
      name: 'Bolívia',
      flag: 'bolivia_flag',
    ),
    DSCountry(
      code: '+387',
      name: 'Bósnia e Herzegovina',
      flag: 'bosnia_and_herzegovina_flag',
    ),
    DSCountry(
      code: '+267',
      name: 'Botswana',
      flag: 'botswana_flag',
    ),
    DSCountry(
      code: '+673',
      name: 'Brunei',
      flag: 'brunei_flag',
    ),
    DSCountry(
      code: '+359',
      name: 'Bulgária',
      flag: 'bulgaria_flag',
    ),
    DSCountry(
      code: '+257',
      name: 'Burundi',
      flag: 'burundi_flag',
    ),
    DSCountry(
      code: '+975',
      name: 'Butão',
      flag: 'bhutan_flag',
    ),
    DSCountry(
      code: '+855',
      name: 'Camboja',
      flag: 'cambodia_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Canadá',
      flag: 'canada_flag',
    ),
    DSCountry(
      code: '+7',
      name: 'Cazaquistão',
      flag: 'kazakhstan_flag',
    ),
    DSCountry(
      code: '+235',
      name: 'Chade',
      flag: 'chad_flag',
    ),
    DSCountry(
      code: '+56',
      name: 'Chile',
      flag: 'chile_flag',
    ),
    DSCountry(
      code: '+86',
      name: 'China',
      flag: 'china_flag',
    ),
    DSCountry(
      code: '+357',
      name: 'Chipre',
      flag: 'northern_cyprus_flag',
    ),
    DSCountry(
      code: '+57',
      name: 'Colômbia',
      flag: 'colombia_flag',
    ),
    DSCountry(
      code: '+269',
      name: 'Comores',
      flag: 'comoros_flag',
    ),
    DSCountry(
      code: '+850',
      name: 'Coreia do Norte',
      flag: 'north_korea_flag',
    ),
    DSCountry(
      code: '+82',
      name: 'Coreia do Sul',
      flag: 'south_korea_flag',
    ),
    DSCountry(
      code: '+225',
      name: 'Costa do Marfim',
      flag: 'ivory_coast_flag',
    ),
    DSCountry(
      code: '+506',
      name: 'Costa Rica',
      flag: 'costa_rica_flag',
    ),
    DSCountry(
      code: '+385',
      name: 'Croácia',
      flag: 'croatia_flag',
    ),
    DSCountry(
      code: '+53',
      name: 'Cuba',
      flag: 'cuba_flag',
    ),
    DSCountry(
      code: '+45',
      name: 'Dinamarca',
      flag: 'denmark_flag',
    ),
    DSCountry(
      code: '+253',
      name: 'Dijibuti',
      flag: 'djibouti_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Dominica',
      flag: 'dominica_flag',
    ),
    DSCountry(
      code: '+20',
      name: 'Egito',
      flag: 'egypt_flag',
    ),
    DSCountry(
      code: '+503',
      name: 'El Salvador',
      flag: 'el_salvador_flag',
    ),
    DSCountry(
      code: '+971',
      name: 'Emirados Árabes Unidos',
      flag: 'united_arab_emirates_flag',
    ),
    DSCountry(
      code: '+593',
      name: 'Equador',
      flag: 'ecuador_flag',
    ),
    DSCountry(
      code: '+291',
      name: 'Eritreia',
      flag: 'eritrea_flag',
    ),
    DSCountry(
      code: '+421',
      name: 'Eslováquia',
      flag: 'slovakia_flag',
    ),
    DSCountry(
      code: '+386',
      name: 'Eslovênia',
      flag: 'slovenia_flag',
    ),
    DSCountry(
      code: '+34',
      name: 'Espanha',
      flag: 'spain_flag',
    ),
    DSCountry(
      code: '+372',
      name: 'Estônia',
      flag: 'estonia_flag',
    ),
    DSCountry(
      code: '+251',
      name: 'Etiópia',
      flag: 'ethiopia_flag',
    ),
    DSCountry(
      code: '+679',
      name: 'Fiji',
      flag: 'fiji_flag',
    ),
    DSCountry(
      code: '+63',
      name: 'Filipinas',
      flag: 'philippines_flag',
    ),
    DSCountry(
      code: '+358',
      name: 'Finlândia',
      flag: 'finland_flag',
    ),
    DSCountry(
      code: '+33',
      name: 'França',
      flag: 'france_flag',
    ),
    DSCountry(
      code: '+241',
      name: 'Gabão',
      flag: 'gabon_flag',
    ),
    DSCountry(
      code: '+220',
      name: 'Gâmbia',
      flag: 'gambia_flag',
    ),
    DSCountry(
      code: '+233',
      name: 'Ghana',
      flag: 'ghana_flag',
    ),
    DSCountry(
      code: '+995',
      name: 'Geórgia',
      flag: 'georgia_flag',
    ),
    DSCountry(
      code: '+350',
      name: 'Gibraltar',
      flag: 'gibraltar_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Granada',
      flag: 'grenada_flag',
    ),
    DSCountry(
      code: '+30',
      name: 'Grécia',
      flag: 'greece_flag',
    ),
    DSCountry(
      code: '+299',
      name: 'Groenlândia',
      flag: 'greenland_flag',
    ),
    DSCountry(
      code: '+671',
      name: 'Guam',
      flag: 'guam_flag',
    ),
    DSCountry(
      code: '+502',
      name: 'Guatemala',
      flag: 'guatemala_flag',
    ),
    DSCountry(
      code: '+224',
      name: 'Guiné',
      flag: 'guinea_flag',
    ),
    DSCountry(
      code: '+245',
      name: 'Guiné-Bissau',
      flag: 'guinea_bissau_flag',
    ),
    DSCountry(
      code: '+509',
      name: 'Haiti',
      flag: 'haiti_flag',
    ),
    DSCountry(
      code: '+31',
      name: 'Holanda',
      flag: 'netherlands_flag',
    ),
    DSCountry(
      code: '+504',
      name: 'Honduras',
      flag: 'honduras_flag',
    ),
    DSCountry(
      code: '+852',
      name: 'Hong Kong',
      flag: 'hong_kong_flag',
    ),
    DSCountry(
      code: '+36',
      name: 'Hungria',
      flag: 'hungary_flag',
    ),
    DSCountry(
      code: '+967',
      name: 'Iêmen',
      flag: 'yemen_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Ilhas Cayman',
      flag: 'cayman_islands_flag',
    ),
    DSCountry(
      code: '+672',
      name: 'Ilha Christmas',
      flag: 'christmas_island_flag',
    ),
    DSCountry(
      code: '+672',
      name: 'Ilhas Cocos',
      flag: 'cocos_island_flag',
    ),
    DSCountry(
      code: '+682',
      name: 'Ilhas Cook',
      flag: 'cook_islands_flag',
    ),
    DSCountry(
      code: '+960',
      name: 'Maldivas',
      flag: 'maldives_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Ilhas Marianas do Norte',
      flag: 'northern_marianas_islands_flag',
    ),
    DSCountry(
      code: '+692',
      name: 'Ilhas Marshall',
      flag: 'marshall_island_flag',
    ),
    DSCountry(
      code: '+672',
      name: 'Ilha Norfolk',
      flag: 'norfolk_island_flag',
    ),
    DSCountry(
      code: '+677',
      name: 'Ilhas Salomão',
      flag: 'solomon_islands_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Ilhas Virgens Americanas',
      flag: 'virgin_islands_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Ilhas Virgens Britânicas',
      flag: 'british_virgin_islands_flag',
    ),
    DSCountry(
      code: '+91',
      name: 'Índia',
      flag: 'india_flag',
    ),
    DSCountry(
      code: '+62',
      name: 'Indonésia',
      flag: 'indonesia_flag',
    ),
    DSCountry(
      code: '+98',
      name: 'Irã',
      flag: 'iran_flag',
    ),
    DSCountry(
      code: '+964',
      name: 'Iraque',
      flag: 'iraq_flag',
    ),
    DSCountry(
      code: '+353',
      name: 'Irlanda',
      flag: 'ireland_flag',
    ),
    DSCountry(
      code: '+354',
      name: 'Islândia',
      flag: 'iceland_flag',
    ),
    DSCountry(
      code: '+972',
      name: 'Israel',
      flag: 'israel_flag',
    ),
    DSCountry(
      code: '+39',
      name: 'Itália',
      flag: 'italy_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Jamaica',
      flag: 'jamaica_flag',
    ),
    DSCountry(
      code: '+81',
      name: 'Japão',
      flag: 'japan_flag',
    ),
    DSCountry(
      code: '+962',
      name: 'Jordânia',
      flag: 'jordan_flag',
    ),
    DSCountry(
      code: '+686',
      name: 'Kiribati',
      flag: 'kiribati_flag',
    ),
    DSCountry(
      code: '+383',
      name: 'Kosovo',
      flag: 'kosovo_flag',
    ),
    DSCountry(
      code: '+965',
      name: 'Kuwait',
      flag: 'kwait_flag',
    ),
    DSCountry(
      code: '+856',
      name: 'Laos',
      flag: 'laos_flag',
    ),
    DSCountry(
      code: '+266',
      name: 'Lesoto',
      flag: 'lesotho_flag',
    ),
    DSCountry(
      code: '+371',
      name: 'Letônia',
      flag: 'latvia_flag',
    ),
    DSCountry(
      code: '+961',
      name: 'Líbano',
      flag: 'lebanon_flag',
    ),
    DSCountry(
      code: '+231',
      name: 'Libéria',
      flag: 'liberia_flag',
    ),
    DSCountry(
      code: '+218',
      name: 'Líbia',
      flag: 'libya_flag',
    ),
    DSCountry(
      code: '+237',
      name: 'Liechtenstein',
      flag: 'liechtenstein_flag',
    ),
    DSCountry(
      code: '+370',
      name: 'Lituânia',
      flag: 'lithuania_flag',
    ),
    DSCountry(
      code: '+352',
      name: 'Luxemburgo',
      flag: 'luxembourg_flag',
    ),
    DSCountry(
      code: '+853',
      name: 'Macau',
      flag: 'macao_flag',
    ),
    DSCountry(
      code: '+389',
      name: 'Macedônia',
      flag: 'republic_of_macedonia_flag',
    ),
    DSCountry(
      code: '+261',
      name: 'Madagascar',
      flag: 'madagascar_flag',
    ),
    DSCountry(
      code: '+60',
      name: 'Malásia',
      flag: 'malasya_flag',
    ),
    DSCountry(
      code: '+265',
      name: 'Malawi',
      flag: 'malawi_flag',
    ),
    DSCountry(
      code: '+223',
      name: 'Mali',
      flag: 'mali_flag',
    ),
    DSCountry(
      code: '+356',
      name: 'Malta',
      flag: 'malta_flag',
    ),
    DSCountry(
      code: '+212',
      name: 'Marrocos',
      flag: 'morocco_flag',
    ),
    DSCountry(
      code: '+596',
      name: 'Martinica',
      flag: 'martinique_flag',
    ),
    DSCountry(
      code: '+230',
      name: 'Maurícia',
      flag: 'mauritius_flag',
    ),
    DSCountry(
      code: '+222',
      name: 'Mauritânia',
      flag: 'mauritania_flag',
    ),
    DSCountry(
      code: '+52',
      name: 'México',
      flag: 'mexico_flag',
    ),
    DSCountry(
      code: '+237',
      name: 'Micronesia',
      flag: 'micronesia_flag',
    ),
    DSCountry(
      code: '+258',
      name: 'Moçambique',
      flag: 'mozambique_flag',
    ),
    DSCountry(
      code: '+373',
      name: 'Moldávia',
      flag: 'moldova_flag',
    ),
    DSCountry(
      code: '+377',
      name: 'Mônaco',
      flag: 'monaco_flag',
    ),
    DSCountry(
      code: '+976',
      name: 'Mongólia',
      flag: 'mongolia_flag',
    ),
    DSCountry(
      code: '+382',
      name: 'Montenegro',
      flag: 'montenegro_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Montserrat',
      flag: 'montserrat_flag',
    ),
    DSCountry(
      code: '+95',
      name: 'Myanmar',
      flag: 'myanmar_flag',
    ),
    DSCountry(
      code: '+264',
      name: 'Namíbia',
      flag: 'namibia_flag',
    ),
    DSCountry(
      code: '+674',
      name: 'Nauru',
      flag: 'nauru_flag',
    ),
    DSCountry(
      code: '+977',
      name: 'Nepal',
      flag: 'nepal_flag',
    ),
    DSCountry(
      code: '+505',
      name: 'Nicarágua',
      flag: 'nicaragua_flag',
    ),
    DSCountry(
      code: '+227',
      name: 'Níger',
      flag: 'niger_flag',
    ),
    DSCountry(
      code: '+234',
      name: 'Nigéria',
      flag: 'nigeria_flag',
    ),
    DSCountry(
      code: '+683',
      name: 'Niue',
      flag: 'niue_flag',
    ),
    DSCountry(
      code: '+47',
      name: 'Noruega',
      flag: 'norway_flag',
    ),
    DSCountry(
      code: '+64',
      name: 'Nova Zelândia',
      flag: 'new_zealand_flag',
    ),
    DSCountry(
      code: '+968',
      name: 'Omã',
      flag: 'oman_flag',
    ),
    DSCountry(
      code: '+680',
      name: 'Palau',
      flag: 'palau_flag',
    ),
    DSCountry(
      code: '+970',
      name: 'Palestina',
      flag: 'palestine_flag',
    ),
    DSCountry(
      code: '+507',
      name: 'Panamá',
      flag: 'panama_flag',
    ),
    DSCountry(
      code: '+675',
      name: 'Papua-Nova Guiné',
      flag: 'papua_new_guinea_flag',
    ),
    DSCountry(
      code: '+92',
      name: 'Paquistão',
      flag: 'pakistan_flag',
    ),
    DSCountry(
      code: '+595',
      name: 'Paraguai',
      flag: 'paraguay_flag',
    ),
    DSCountry(
      code: '+51',
      name: 'Peru',
      flag: 'peru_flag',
    ),
    DSCountry(
      code: '+689',
      name: 'Polinésia Francesa',
      flag: 'french_polynesia_flag',
    ),
    DSCountry(
      code: '+48',
      name: 'Polônia',
      flag: 'poland_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Porto Rico',
      flag: 'puerto_rico_flag',
    ),
    DSCountry(
      code: '+351',
      name: 'Portugal',
      flag: 'portugal_flag',
    ),
    DSCountry(
      code: '+974',
      name: 'Qatar',
      flag: 'qatar_flag',
    ),
    DSCountry(
      code: '+254',
      name: 'Quênia',
      flag: 'kenya_flag',
    ),
    DSCountry(
      code: '+996',
      name: 'Quirguistão',
      flag: 'kyrgyzstan_flag',
    ),
    DSCountry(
      code: '+44',
      name: 'Reino Unido',
      flag: 'united_kingdom_flag',
    ),
    DSCountry(
        code: '+236',
        name: 'República Centro-Africana',
        flag: 'central_african_republic_flag'),
    DSCountry(
        code: '+1',
        name: 'República Dominicana',
        flag: 'dominican_republic_flag'),
    DSCountry(
      code: '+420',
      name: 'República Tcheca',
      flag: 'czech_republic_flag',
    ),
    DSCountry(
      code: '+40',
      name: 'Romênia',
      flag: 'romania_flag',
    ),
    DSCountry(
      code: '+250',
      name: 'Ruanda',
      flag: 'rwanda_flag',
    ),
    DSCountry(
      code: '+7',
      name: 'Rússia',
      flag: 'russia_flag',
    ),
    DSCountry(
      code: '+685',
      name: 'Samoa',
      flag: 'samoa_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Samoa Americana',
      flag: 'american_samoa_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Santa Lúcia',
      flag: 'st_lucia_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'São Cristóvão e Nevis',
      flag: 'saint_kitts_and_nevis_flag',
    ),
    DSCountry(
      code: '+378',
      name: 'São Marinho',
      flag: 'san_marino_flag',
    ),
    DSCountry(
      code: '+239',
      name: 'São Tomé e Príncipe',
      flag: 'sao_tome_and_prince_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'São Vicente e Granadinas',
      flag: 'st_vincent_and_the_grenadines_flag',
    ),
    DSCountry(
      code: '+248',
      name: 'Seicheles',
      flag: 'seychelles_flag',
    ),
    DSCountry(
      code: '+221',
      name: 'Senegal',
      flag: 'senegal_flag',
    ),
    DSCountry(
      code: '+232',
      name: 'Serra Leoa',
      flag: 'sierra_leone_flag',
    ),
    DSCountry(
      code: '+381',
      name: 'Sérvia',
      flag: 'serbia_flag',
    ),
    DSCountry(
      code: '+65',
      name: 'Singapura',
      flag: 'singapore_flag',
    ),
    DSCountry(
      code: '+963',
      name: 'Síria',
      flag: 'syria_flag',
    ),
    DSCountry(
      code: '+252',
      name: 'Somália',
      flag: 'somalia_flag',
    ),
    DSCountry(
      code: '+94',
      name: 'Sri Lanka',
      flag: 'sri_lanka_flag',
    ),
    DSCountry(
      code: '+249',
      name: 'Sudão',
      flag: 'sudan_flag',
    ),
    DSCountry(
      code: '+211',
      name: 'Sudão do Sul',
      flag: 'south_sudan_flag',
    ),
    DSCountry(
      code: '+46',
      name: 'Suécia',
      flag: 'sweden_flag',
    ),
    DSCountry(
      code: '+41',
      name: 'Suíça',
      flag: 'switzerland_flag',
    ),
    DSCountry(
      code: '+597',
      name: 'Suriname',
      flag: 'suriname_flag',
    ),
    DSCountry(
      code: '+992',
      name: 'Tadjiquistão',
      flag: 'tajikistan_flag',
    ),
    DSCountry(
      code: '+66',
      name: 'Tailândia',
      flag: 'thailand_flag',
    ),
    DSCountry(
      code: '+886',
      name: 'Taiwan',
      flag: 'taiwan_flag',
    ),
    DSCountry(
      code: '+255',
      name: 'Tanzânia',
      flag: 'tanzania_flag',
    ),
    DSCountry(
      code: '+246',
      name: 'Território Britânico do Oceano Índico',
      flag: 'british_indian_ocean_territory_flag',
    ),
    DSCountry(
      code: '+670',
      name: 'Timor Leste',
      flag: 'east_timor_flag',
    ),
    DSCountry(
      code: '+228',
      name: 'Togo',
      flag: 'togo_flag',
    ),
    DSCountry(
      code: '+690',
      name: 'Tokelau',
      flag: 'tokelau_flag',
    ),
    DSCountry(
      code: '+676',
      name: 'Tonga',
      flag: 'tonga_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Trinidad e Tobago',
      flag: 'trinidad_and_tobago_flag',
    ),
    DSCountry(
      code: '+216',
      name: 'Tunísia',
      flag: 'tunisia_flag',
    ),
    DSCountry(
      code: '+1',
      name: 'Turcas e Caicos',
      flag: 'turks_and_caicos_flag',
    ),
    DSCountry(
      code: '+993',
      name: 'Turquemenistão',
      flag: 'turkmenistan_flag',
    ),
    DSCountry(
      code: '+90',
      name: 'Turquia',
      flag: 'turkey_flag',
    ),
    DSCountry(
      code: '+638',
      name: 'Tuvalu',
      flag: 'tuvalu_flag',
    ),
    DSCountry(
      code: '+380',
      name: 'Ucrânia',
      flag: 'ukraine_flag',
    ),
    DSCountry(
      code: '+256',
      name: 'Uganda',
      flag: 'uganda_flag',
    ),
    DSCountry(
      code: '+598',
      name: 'Uruguai',
      flag: 'uruguay_flag',
    ),
    DSCountry(
      code: '+998',
      name: 'Uzbequistão',
      flag: 'uzbekistn_flag',
    ),
    DSCountry(
      code: '+678',
      name: 'Vanuatu',
      flag: 'vanuatu_flag',
    ),
    DSCountry(
      code: '+379',
      name: 'Vaticano',
      flag: 'vatican_city_flag',
    ),
    DSCountry(
      code: '+58',
      name: 'Venezuela',
      flag: 'venezuela_flag',
    ),
    DSCountry(
      code: '+84',
      name: 'Vietnã',
      flag: 'vietnam_flag',
    ),
    DSCountry(
      code: '+260',
      name: 'Zâmbia',
      flag: 'zambia_flag',
    ),
    DSCountry(
      code: '+263',
      name: 'Zimbábue',
      flag: 'zimbabwe_flag',
    ),
  ];
}
