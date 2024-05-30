import 'package:flutter/cupertino.dart';
import 'package:shop/models/ProductModel.dart'; // 导入 ProductModel 文件

class ProductsProvider with ChangeNotifier {
  //商品Map
  Map<String, Product> products = {
    'hat': hat,
    'angel': angel,
    'toy': toy,
    'tool': tool,
  };
  //products['hat'] 返回的是一个名为 hat 的商品对象

  /*创建实例根据Map获取具体商品provider
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final hatProvider = productsProvider.products['hat'];

    return Consumer<ProductsProvider>(
   */

  //根据id获取对应商品
  Product getProductById(String id) {
    return products[id] ?? Product.empty(); // 使用默认的空商品对象
  }

  // 商品实例
  // 帽子 hat
  static final Product hat = Product(
    id: 'hat',
    name: "The Drop Women's Maldives Sun Hat",
    price: 25.42,
    description:
        'The Drop is your inside source for must-have style inspiration from global influencers. Shop limited-edition collections and discover chic wardrobe essentials from Staples by the Drop. Look out for trend inspiration, exclusive brand collaborations, and expert styling tips from those in the know.',
    images: [
      'assets/images/hat03.jpg',
      'assets/images/hat02.jpg',
      'assets/images/hat.jpg',
    ],
    reviews: [
      Review(
          username: 'Anny',
          comment:
              'Beautiful item and fairly priced. Just a tad too large for my head and frame. I can definitely see someone carrying this off, sadly, not me.',
          stars: 4),
      Review(
        username: 'きりのなつお',
        comment: '大好きです,お財布にぴったりです',
        stars: 5,
      ),
      Review(
        username: 'Chigozie Nnodim',
        comment:
            'This hat was perfect on my vacation. It wasn’t too big and gave the right amount of shade. It’s also very versatile as it can be dressed up and down depending on your preference!',
        stars: 4,
      ),
      Review(
        username: 'Stiff',
        comment: 'good hat!',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );

  // 天使 angel
  static final Product angel = Product(
    id: 'angel',
    name: 'Willow Tree Angel of Comfort Figure',
    price: 29.90,
    description: '''· Sentiment: ”Offering an embrace of comfort and love” written on Enclosure Card
· 3.5”h hand-painted resin figure with wire wings of boy angel in cream onesie, seated with brown dog in lap.
· A gift to express sympathy, comfort, remembrance and healing. Packaged in fitted box ready for gift-giving.
· Artist Susan Lordi hand carves the original of each Willow Tree piece from her studio in Kansas City, MO. This piece is cast from Susan's original carving and painted by hand.
· Ready to display on a shelf, table or mantel. To clean, dust with soft brush or cloth.''',
    images: [
      'assets/images/Angel02.jpg',
      'assets/images/Angel03.jpg',
      'assets/images/Angel04.jpg',
      'assets/images/Angel05.jpg',
      'assets/images/Angel06.jpg',
    ],
    reviews: [
      Review(
          username: 'Monkey Customer',
          comment: 'Beautiful and delicately made. Love it!!',
          stars: 5),
      Review(
        username: 'Aladrya',
        comment:
            "Magnifique petit ange, il est posé a coté de l'urne de ma chienne adoré . Un bel objet a offrir ou a garder pour rendre un dernier hommage a nos boules d'amours .",
        stars: 5,
      ),
      Review(
        username: 'Maria M.',
        comment:
            'Lo compre porque perdí a mi ángel de 4 patas. Lo tengo puesto junto a su urna. Me ayuda saber que otro ángel está cuidando de él allá arriba en el puente del arco iris.',
        stars: 5,
      ),
      Review(
        username: '	Mary Jo T',
        comment: 'Beautiful, it’s exactly what I expected',
        stars: 5,
      ),
    ],
    isFavorite: false,
  );

  //玩具 toy
  static final Product toy = Product(
    id: 'toy',
    name: "Montessori Ball Tracker",
    price: 49.99,
    description:
        '''【Montessori Toy for Kids】This Multi-color pound a ball montessori toy is ideal for hammering practice, Promotes dexterity, hand eye coordination, manipulation, arm movement, cause and effect. They will love this gift and play with parents or friends for hours.
【Funny Pound a Ball Toy】The smooth-sanded balls drop down after hammered, Then color bright balls rolling down the ramp out on the bottom tray. The Ball Drop Toy is the perfect interactive game toy for Parent-child to enjoy together, competing to see who can get a better score.
【Safety Always Come First】This montessori toys is made of high-quality wood, safe and non-toxic and free of burrs or sharp. It meets the US toy standards: ASTM, CPSIA, and CPC. Every piece is made with the utmost care and quality control.We take great pride in our toddler toys.
【Best Gift for Baby Kids】This ball toy makes a perfect birthday gift for your child and their friends. They'll unwrap it at the party and play together! This toy will provide toddler boys & girls a happy hammer and pounding experience, they will have fun playing with this toy.
【100% Satisfaction Guarnatee】We have strived to provide more high-quality educational toys for your kids. Let baby with hours of indoor fun and a favorite preschool play activity for kids and parents.All of my products offer a 6-month warranty. Please feel free to contact us if have any question.
 ''',
    images: [
      'assets/images/toy.jpg',
      'assets/images/toy01.jpg',
      'assets/images/toy02.jpg',
      'assets/images/toy03.jpg',
      'assets/images/toy04.jpg',
    ],
    reviews: [
      Review(
          username: 'Sara',
          comment:
              'I was really skeptical when I bought this toy as there were no reviews. We’ve had it for 6 months now. It has held up really well so far and our 18 month old loves it. Really glad that I purchased it and would definitely recommend!',
          stars: 5),
      Review(
        username: 'Jamie M.',
        comment: '''
Super disappointed. Bought this as a gift and the balls are completely dented with big holes in them.
''',
        stars: 1,
      ),
      Review(
        username: 'lt',
        comment:
            'This is a great toy, but one side of it wasn’t pushed all of the way into the groove before it was glued and was actually pretty rough.',
        stars: 4,
      ),
      Review(
        username: 'Renita',
        comment:
            'My baby is currently interested in cause and effected so I bought him this lovely ball tracker and he loves it.',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );

  //工具 tool
  static final Product tool = Product(
    id: 'tool',
    name: "General Household Home Repair and Mechanic's Hand Tool Kit Set",
    price: 69.33,
    description:
        '''· 173-piece hand tool set for basic household repairs and everyday projects; includes 8 combination wrenches, 3/8-inch ratchet wrench, 22 hex keys, 6-inch slip-joint pliers, 6-inch long nose pliers, and more (scroll down to view complete list)
· Made of durable heat-treated and chrome-plated alloy steel for long-lasting, corrosion-resistant strength
· Plastic non-slip handles provide enhanced comfort and control
· Blow-molded case provides secure tool storage and convenient portability
· Measures 16.89 by 12.68 by 3.35 inches; backed by an Amazon Basics 1-year limited warranty
· Warning: Wear safety goggles to ensure your safety whilst using the hand hammer
 ''',
    images: [
      'assets/images/tool.jpg',
      'assets/images/tool02.jpg',
      'assets/images/tool03.jpg',
      'assets/images/tool04.jpg',
      'assets/images/tool05.jpg',
    ],
    reviews: [
      Review(
          username: 'Le Dac Anh Minh',
          comment:
              'Bon produit, très utile et compact, bon rapport qualité - prix, livraison rapide',
          stars: 5),
      Review(
        username: 'Frank',
        comment: '''
I haven't had a chance to test out the tools, but they seem to be a decent quality for the price. However, the case looks pretty flimsy and leaves small gap on one side when closed. Might have to return this set.
''',
        stars: 3,
      ),
      Review(
        username: 'lt',
        comment:
            'This is a great toy, but one side of it wasn’t pushed all of the way into the groove before it was glued and was actually pretty rough.',
        stars: 4,
      ),
      Review(
        username: 'Franziska Angerstein',
        comment: 'Super vielseitig,genug Werkzeuge drinnen,super Qualität.',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );
}
