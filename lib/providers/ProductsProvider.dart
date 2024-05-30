import 'package:flutter/cupertino.dart';
import 'package:shop/models/ProductModel.dart'; // 导入 ProductModel 文件

class ProductsProvider with ChangeNotifier {
  //商品Map
  Map<String, Product> products = {
    'hat': hat,
    'angel': angel,
    'toy': toy,
    'tool': tool,
    'planter': planter,
    'dumbbell': dumbbell,
    'tree': tree,
    'basket': basket,
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

  //盆栽 planter
  static final Product planter = Product(
    id: 'planter',
    name: "GUGUGO Abstract Rainbow Head Planter",
    price: 26.99,
    description:
        '''· 【Colorful and Unique】You will be obsessed with the bohemian use of colors to the design on its abstract face, which can brighten the look of your plants and flowers. Also, the decorative head planter always looks so sleepy and zen, one made especially amiable by a beaming smile.
· 【Hand Painted】Every single eclectic head flower pot is hand painted unique. Due to the handmade nature, it could be allowed there may be minor imperfections on the flower plant pots. Your purchase helps invest in the work of our local artisans and give back to the local community.
· 【Switch Out Hairdo】There is amble room for any smaller lighter indoor plants looks like hair, such as string of pearls, succulent, cactus, fern, air plant, and artificial greens. Also good at holding other things, such as sticks, pens, paint brushes.
· 【Sturdy Yet Lightweight】The cute face planters pots are sturdy for being resin cast and robust with a water resistant finish. Come with a larger drainage hole and a removable rubber plug, also planters have pads underneath to against scratching furniture. Size: 5.55’’ Diameter x 5.23" Height. Plants are not included.
· 【Breathtaking Gifts】GUGUGO is a design-oriented brand. These vintage retro piece of home decor will add character and visual intrigue to your garden or desk, shelf, windowsill. Perfect as unique room decor aesthetic for plant lover gifts at birthday, wedding, housewarming, Valentine's Day, Mother’s Day, Christmas Day.
 ''',
    images: [
      'assets/images/planter.jpg',
      'assets/images/planter01.jpg',
      'assets/images/planter02.jpg',
      'assets/images/planter03.jpg',
      'assets/images/planter04.jpg',
    ],
    reviews: [
      Review(username: 'D. Atwood', comment: 'Very cute but overpriced', stars: 4),
      Review(
        username: 'Andrew Szava-kovats',
        comment: '''
Looks even better in real life than it does in listing photos. Good solid material build quality. I'm glad there's a drain hole with plug. And the little rubber help with placement.
''',
        stars: 5,
      ),
      Review(
        username: 'Tom4492',
        comment: 'Conforme a la photo',
        stars: 5,
      ),
      Review(
        username: 'Nicola Clark',
        comment: 'Beautiful little plant pot, looks amazing',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );

  //哑铃 dumbbell
  static final Product dumbbell = Product(
    id: 'dumbbell',
    name: "Basics Neoprene Coated Hexagon Workout Dumbbell Hand Weight",
    price: 26.99,
    description: '''· 2 pound dumbbell (set of 2) for exercise and strength training
· Neoprene coating in Pink offers long lasting durability
· Hexagon shaped ends prevent dumbbells from rolling away and offer stay-in-place storage
· Nonslip grip promotes a comfortable, secure hold
· Available in multiple sizes to mix and match for specific workout needs and to expand on over time
· Printed weight number on each end cap and color coded for quick identification
 ''',
    images: [
      'assets/images/dumbbell02.jpg',
      'assets/images/dumbbell01.jpg',
      'assets/images/dumbbell.jpg',
    ],
    reviews: [
      Review(
        username: 'Ruan B.',
        comment:
            'They sent me the wrong sizes and they came in the wrong colours. The weights themselves are good quality and so is the stand. However the colour on the yellow weights immediately started coming off on my hands and nails. Good weights but not pleased with the service of the company or their commitment to customer service.',
        stars: 1,
      ),
      Review(
        username: 'Nora PG',
        comment: '''
Me gustó mucho !!!!
Muy buena calidad! El soporte es muy práctico y mantiene las pesas en su lugar !
Súper compra !!!!!!!!
''',
        stars: 5,
      ),
      Review(
        username: 'Mary',
        comment:
            'Great quality and was a good value when I bought them on Black Friday sale. I like the rubber around the dumbbells which is nicer to hold and more comfortable.',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );

  //树 tree
  static final Product tree = Product(
    id: 'tree',
    name: "Halloween Easter Garden Decorations Creative",
    price: 18.99,
    description:
        '''★[MATERIAL TECHNOLOGY]:The unique planters uses high-quality resin as raw material, fine workmanship, rich colors, 3D mold makes the decoration more realistic, durable material, corrosion resistance and longer service life.
★[DRAINAGE HOLE DESIGN]:The bottom of the face planters pots head is designed with drainage holes for watering, which is suitable for the growth of juicy plants with developed roots. The root system of the plant has the advantages of good drainage, no water accumulation, and no water accumulation.
★[MULTI FUNCTION DESIGN]:The face plant pots design is funny and cool. It is suitable for indoor and outdoor decoration. It can also be put on the desk, dining table and living room as a flowerpot of succulent plants. It can also be used as decoration and pen container storage box.
★[BEST GIFT CHICE]:The Easter island planter is the best gift for horticultural enthusiasts, planters for indoor plants, as well as for Fathers Day Gifts, Easter, Halloween, Christmas gifts and stocking stuffers for adults. They can be used as flowerpots for succulent plants or as interior decorations.
★[SINCERE SERVICE]:We are committed to bringing comfortable shopping experience to our customers,If you have any questions about the order, please feel free to contact us and we will reply and solve them immediately.
 ''',
    images: [
      'assets/images/tree.jpg',
      'assets/images/tree01.jpg',
      'assets/images/tree02.jpg',
    ],
    reviews: [
      Review(
        username: 'Bobbi Cammons',
        comment:
            'Planter itself is cute, however the inside is oval shaped. Smaller then I had pictured based on dimensions provided. Unable to use it for the plant I intended to use it for.',
        stars: 3,
      ),
      Review(
        username: 'Seciob',
        comment: '''
Very cute design. It's pretty small, but like it!
''',
        stars: 4,
      ),
      Review(
        username: 'Rusty',
        comment: 'Awesome little planters. Love the face!',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );

  //篮 basket
  static final Product basket = Product(
    id: 'basket',
    name: "KAKAMAY Large Blanket Basket ",
    price: 29.99,
    description: '''100%Cotton
【100% NATURAL HANDMADE】:100% cotton rope,soft material without any chemicals woven basket. There are No plastics. No harsh chemicals. Our basket is soft and safe for kids and pets.our rope baskets are super durable and hold their shape well. they can be hand washed / air dried or put in your washer / dryer on delicate.
【LARGE SIZE】: 20"x20"x13",which is a perfect storage basket in living room for blankets, throw pillows, comforter or cushions,blankets, baby diapers or toys. Use for toy storage organization, toy basket, throw basket, laundry basket, etc. to keep your living space neat and tidy!
【MULTI-PURPOSE STORAGE】:Decorative Basket is a new stylish alternative for all of your storage needs and it fits perfect with any kind of Home Decor. nothing will be lying around when you have our woven baskets in your home. Designed in subtle colors, this nursery organizer basket is too pretty to keep inside.
【PORTABLE,STURDY&FOLDABLE】:Soft and firm basket, no collision scratches, perfect to accommodate baby's clothes and other toys in nursery. A great laundry storage basket that will last for years of continuous use. Rope will not separate, fray, or fall apart. We use highest grade materials and construction. You can feel and see the impressive difference the moment you receive it.
【Note】: The basket comes in folded. It will return to its best shape if filling it up with towels or blankets. Fast removing the creases by ironing them. Washable: Hand washing or machine washing. When wash by machine, better place it in a laundry bag. Air-dry is better or you can dryer on a delicate cycle.
 ''',
    images: [
      'assets/images/basket.jpg',
      'assets/images/basket01.jpg',
      'assets/images/basket02.jpg',
      'assets/images/basket03.jpg',
    ],
    reviews: [
      Review(
        username: 'Natasha',
        comment:
            '''Absolutely love this product, it's big and very durable fabric. Looks like some of my other baskets I've purchased but for a better price! It was packaged so cute too.''',
        stars: 5,
      ),
      Review(
        username: 'Damaris Scalzi',
        comment: '''
Great quality! A nice size for the price!
''',
        stars: 4,
      ),
      Review(
        username: 'Renate McGovern',
        comment:
            'Beautiful basket, great quality, came out bigger then i thought but its ok i love it and would order it again, also very nicely packed.Thank You',
        stars: 5,
      ),
    ],
    isFavorite: false, // 默认为未收藏状态
  );
}
