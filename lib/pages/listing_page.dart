// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'dart:async';
// // import '../service/mic.dart';
// // import '../widgets/greet.dart';
// // import '../service/handle_teams.dart';

// // class ListingPage extends StatefulWidget {
// //   const ListingPage({super.key});

// //   @override
// //   _ListingPageState createState() => _ListingPageState();
// // }

// // class _ListingPageState extends State<ListingPage> {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //   final MicService _micService = MicService();
// //   bool _micActive = false;
// //   Map<String, Map<String, dynamic>> _teamData = {};
// //   Map<String, List<QueryDocumentSnapshot>> _teamItems = {};
// //   String? _expandedTeamId;
// //   bool _isLoading = true;
// //   final User? _currentUser = FirebaseAuth.instance.currentUser;
// //   final Trie _trie = Trie(); // Trie instance for suggestions
// //   static const List<String> groceryItems = [
// //     "Apple",
// //     "Banana",
// //     "Carrot",
// //     "Tomato",
// //     "Potato",
// //     "Onion",
// //     "Garlic",
// //     "Cucumber",
// //     "Lettuce",
// //     "Spinach",
// //     "Broccoli",
// //     "Cauliflower",
// //     "Peas",
// //     "Bell Pepper",
// //     "Zucchini",
// //     "Eggplant",
// //     "Cabbage",
// //     "Radish",
// //     "Squash",
// //     "Pumpkin",
// //     "Mushroom",
// //     "Asparagus",
// //     "Brussels Sprouts",
// //     "Green Beans",
// //     "Sweet Potato",
// //     "Corn",
// //     "cake",
// //     "Olives",
// //     "Avocado",
// //     "Berries",
// //     "Blueberries",
// //     "Strawberries",
// //     "Raspberries",
// //     "Blackberries",
// //     "Grapes",
// //     "Pineapple",
// //     "Mango",
// //     "Peach",
// //     "Plum",
// //     "Pear",
// //     "Orange",
// //     "Lemon",
// //     "Lime",
// //     "Grapefruit",
// //     "Kiwi",
// //     "Pomegranate",
// //     "Papaya",
// //     "Watermelon",
// //     "Melon",
// //     "Cantaloupe",
// //     "Cherries",
// //     "Coconut",
// //     "Apricot",
// //     "Fig",
// //     "Date",
// //     "Figs",
// //     "Tangerine",
// //     "Mandarin",
// //     "Clementine",
// //     "Lemonade",
// //     "Apple Juice",
// //     "Tomato Sauce",
// //     "Coconut Milk",
// //     "Pineapple Juice",
// //     "Orange Juice",
// //     "Fruit Salad",
// //     "Carrot Juice",
// //     "Cucumber Juice",
// //     "Ginger",
// //     "Chili",
// //     "Cilantro",
// //     "Parsley",
// //     "Basil",
// //     "Thyme",
// //     "Rosemary",
// //     "Oregano",
// //     "Sage",
// //     "Bay Leaves",
// //     "Chives",
// //     "Dill",
// //     "Mint",
// //     "Curry Powder",
// //     "Paprika",
// //     "Turmeric",
// //     "Chili Powder",
// //     "Garlic Powder",
// //     "Onion Powder",
// //     "Cumin",
// //     "Coriander",
// //     "Mustard",
// //     "Salt",
// //     "Black Pepper",
// //     "Peppercorn",
// //     "Soy Sauce",
// //     "Olive Oil",
// //     "Canola Oil",
// //     "Vegetable Oil",
// //     "Coconut Oil",
// //     "Sesame Oil",
// //     "Avocado Oil",
// //     "Peanut Oil",
// //     "Vinegar",
// //     "Balsamic Vinegar",
// //     "White Vinegar",
// //     "Rice Vinegar",
// //     "Apple Cider Vinegar",
// //     "Honey",
// //     "Maple Syrup",
// //     "Brown Sugar",
// //     "White Sugar",
// //     "Stevia",
// //     "Agave Syrup",
// //     "Molasses",
// //     "Corn Syrup",
// //     "Baking Powder",
// //     "Baking Soda",
// //     "Cornstarch",
// //     "Flour",
// //     "All-Purpose Flour",
// //     "Whole Wheat Flour",
// //     "Self-Raising Flour",
// //     "Almond Flour",
// //     "Rice Flour",
// //     "Coconut Flour",
// //     "Gluten-Free Flour",
// //     "Oats",
// //     "Rolled Oats",
// //     "Instant Oats",
// //     "Steel-Cut Oats",
// //     "Rice",
// //     "White Rice",
// //     "Brown Rice",
// //     "Jasmine Rice",
// //     "Basmati Rice",
// //     "Sushi Rice",
// //     "Wild Rice",
// //     "Quinoa",
// //     "Couscous",
// //     "Barley",
// //     "Millet",
// //     "Pasta",
// //     "Spaghetti",
// //     "Penne",
// //     "Fusilli",
// //     "Macaroni",
// //     "Lasagna",
// //     "Ravioli",
// //     "Tortellini",
// //     "Noodles",
// //     "Ramen",
// //     "Rice Noodles",
// //     "Udon",
// //     "Egg Noodles",
// //     "Penne Rigate",
// //     "Farfalle",
// //     "Orzo",
// //     "Fettuccine",
// //     "Tortilla",
// //     "Bagels",
// //     "Bread",
// //     "Whole Wheat Bread",
// //     "Sourdough",
// //     "Multigrain Bread",
// //     "Rye Bread",
// //     "Pita Bread",
// //     "Ciabatta",
// //     "Baguette",
// //     "Croissant",
// //     "English Muffins",
// //     "Taco Shells",
// //     "Wraps",
// //     "Hot Dog Buns",
// //     "Hamburger Buns",
// //     "Rolls",
// //     "Crackers",
// //     "Rice Cakes",
// //     "Granola",
// //     "Cereal",
// //     "Cornflakes",
// //     "Muesli",
// //     "Cheerios",
// //     "Frosted Flakes",
// //     "Oatmeal",
// //     "Chia Seeds",
// //     "Flax Seeds",
// //     "Sunflower Seeds",
// //     "Pumpkin Seeds",
// //     "Sesame Seeds",
// //     "Peanuts",
// //     "Almonds",
// //     "Cashews",
// //     "Walnuts",
// //     "Pistachios",
// //     "Pecans",
// //     "Hazelnuts",
// //     "Brazil Nuts",
// //     "Macadamia Nuts",
// //     "Chickpeas",
// //     "Lentils",
// //     "Black Beans",
// //     "Kidney Beans",
// //     "Pinto Beans",
// //     "Garbanzo Beans",
// //     "Navy Beans",
// //     "Red Beans",
// //     "White Beans",
// //     "Soy Beans",
// //     "Tofu",
// //     "Tempeh",
// //     "Edamame",
// //     "Hummus",
// //     "Tahini",
// //     "Peanut Butter",
// //     "Almond Butter",
// //     "Cashew Butter",
// //     "Sunflower Butter",
// //     "Olives",
// //     "Pickles",
// //     "Sauerkraut",
// //     "Kimchi",
// //     "Mayonnaise",
// //     "Mustard",
// //     "Ketchup",
// //     "Barbecue Sauce",
// //     "Hot Sauce",
// //     "Salsa",
// //     "Relish",
// //     "Chutney",
// //     "Tzatziki",
// //     "Soy Sauce",
// //     "Worcestershire Sauce",
// //     "Tabasco Sauce",
// //     "Fish Sauce",
// //     "Steak Sauce",
// //     "Lemon Juice",
// //     "Lime Juice",
// //     "Orange Juice",
// //     "Vegan Cheese",
// //     "Cheddar Cheese",
// //     "Mozzarella",
// //     "Parmesan",
// //     "Feta Cheese",
// //     "Ricotta",
// //     "Cottage Cheese",
// //     "Cream Cheese",
// //     "Brie",
// //     "Goat Cheese",
// //     "Gouda",
// //     "Swiss Cheese",
// //     "Blue Cheese",
// //     "Provolone",
// //     "Pepper Jack Cheese",
// //     "Monterey Jack Cheese",
// //     "American Cheese",
// //     "Camembert",
// //     "Creamer",
// //     "Yogurt",
// //     "Greek Yogurt",
// //     "Skyr",
// //     "Coconut Yogurt",
// //     "Almond Milk",
// //     "Soy Milk",
// //     "Oat Milk",
// //     "Rice Milk",
// //     "Coconut Milk",
// //     "Whole Milk",
// //     "2% Milk",
// //     "1% Milk",
// //     "Skim Milk",
// //     "Buttermilk",
// //     "Heavy Cream",
// //     "Half and Half",
// //     "Sour Cream",
// //     "Eggs",
// //     "Butter",
// //     "Margarine",
// //     "Ghee",
// //     "Shortening",
// //     "Cream Cheese",
// //     "Ice Cream",
// //     "Frozen Yogurt",
// //     "Gelato",
// //     "Sorbet",
// //     "Frozen Vegetables",
// //     "Frozen Fruits",
// //     "Frozen Pizza",
// //     "Frozen Dinner",
// //     "Frozen Fries",
// //     "Frozen Waffles",
// //     "Frozen Fish",
// //     "Frozen Meat",
// //     "Frozen Chicken",
// //     "Frozen Shrimp",
// //     "Frozen Burritos",
// //     "Frozen Smoothie Packs",
// //     "Frozen Breakfast Foods",
// //     "Canned Beans",
// //     "Canned Vegetables",
// //     "Canned Tomatoes",
// //     "Canned Fruit",
// //     "Canned Tuna",
// //     "Canned Salmon",
// //     "Canned Chicken",
// //     "Canned Soup",
// //     "Canned Chili",
// //     "Canned Mushrooms",
// //     "Canned Corn",
// //     "Canned Peas",
// //     "Canned Coconut Milk",
// //     "Canned Corned Beef",
// //     "Canned Sardines",
// //     "Canned Pineapple",
// //     "Canned Peaches",
// //     "Canned Baked Beans",
// //     "Canned Spaghetti",
// //     "Canned Pasta",
// //     "Canned Chicken Broth",
// //     "Canned Beef Broth",
// //     "Canned Vegetable Broth",
// //     "Canned Pumpkin",
// //     "Canned Carrots",
// //     "Canned Olives",
// //     "Frozen Vegetables",
// //     "Frozen Pizza",
// //     "Frozen Meals",
// //     "Frozen Meatballs",
// //     "Frozen Fish Sticks",
// //     "Frozen Fries",
// //     "Frozen Breakfast Foods",
// //     "Frozen Tater Tots",
// //     "Frozen Hash Browns",
// //     "Frozen Bagels",
// //     "Frozen Dumplings",
// //     "Frozen Chicken Wings",
// //     "Frozen Waffles",
// //     "Frozen Pancakes",
// //     "Frozen Fruit",
// //     "Frozen Vegetables",
// //     "Frozen Bread",
// //     "Frozen Pizza Dough",
// //     "Frozen Garlic Bread",
// //     "Frozen Pastry",
// //     "Frozen Pretzels",
// //     "Frozen Pies",
// //     "Frozen Burritos",
// //     "Frozen Smoothies",
// //     "Frozen Smoothie Packs",
// //     "Notebook",
// //     "Pen",
// //     "Pencil",
// //     "Eraser",
// //     "Sharpener",
// //     "Highlighter",
// //     "Marker",
// //     "Sticky Notes",
// //     "Post-it Notes",
// //     "Whiteboard",
// //     "Whiteboard Marker",
// //     "Clipboard",
// //     "Stapler",
// //     "Staple Remover",
// //     "Paper Clips",
// //     "Binder Clips",
// //     "Scissors",
// //     "Glue Stick",
// //     "PVA Glue",
// //     "Tape",
// //     "Double-Sided Tape",
// //     "Masking Tape",
// //     "Scotch Tape",
// //     "Cello Tape",
// //     "Craft Paper",
// //     "Construction Paper",
// //     "Cardstock",
// //     "Tracing Paper",
// //     "Graph Paper",
// //     "Colored Paper",
// //     "A4 Paper",
// //     "Legal Pads",
// //     "Index Cards",
// //     "Flash Cards",
// //     "Envelope",
// //     "Business Cards",
// //     "Card Holders",
// //     "File Folders",
// //     "Hanging Folders",
// //     "Portfolio",
// //     "Binder",
// //     "Ring Binder",
// //     "Lever Arch File",
// //     "File Box",
// //     "Filing Cabinet",
// //     "File Divider",
// //     "Document Wallet",
// //     "Document Sleeve",
// //     "Document Folder",
// //     "Binder Pockets",
// //     "Paper Fasteners",
// //     "Punching Machine",
// //     "Hole Punch",
// //     "Binder Rings",
// //     "Index Dividers",
// //     "Tab Dividers",
// //     "Binder Spine Labels",
// //     "Paper Cutter",
// //     "Paper Trimmer",
// //     "Laminator",
// //     "Laminating Pouches",
// //     "Ruler",
// //     "Tape Measure",
// //     "Compass",
// //     "Protractor",
// //     "Triangle Ruler",
// //     "Set Square",
// //     "Letter Opener",
// //     "Bookends",
// //     "Bookmarks",
// //     "Label Maker",
// //     "Address Labels",
// //     "Name Tags",
// //     "Rubber Stamps",
// //     "Stamp Pads",
// //     "Ink Pads",
// //     "Ink Refills",
// //     "Stamp Ink",
// //     "Stickers",
// //     "Washi Tape",
// //     "Glitter Glue",
// //     "Craft Scissors",
// //     "Cutting Mat",
// //     "Craft Knife",
// //     "Rotary Cutter",
// //     "Scrapbook",
// //     "Scrapbook Paper",
// //     "Photo Corners",
// //     "Corner Rounder",
// //     "Memory Album",
// //     "Stamping Blocks",
// //     "Punches",
// //     "Die Cuts",
// //     "Brads",
// //     "Eyelets",
// //     "Lace Ribbon",
// //     "Satin Ribbon",
// //     "Burlap Ribbon",
// //     "Cotton Thread",
// //     "Embroidery Thread",
// //     "Beads",
// //     "Button Pins",
// //     "Safety Pins",
// //     "Paperclips",
// //     "Clothespins",
// //     "Tack Pins",
// //     "Binder Clips",
// //     "Rubber Bands",
// //     "Elastic Bands",
// //     "Safety Pins",
// //     "Thimble",
// //     "Seam Ripper",
// //     "Iron-on Transfers",
// //     "Fabric Paint",
// //     "Embroidery Floss",
// //     "Beading Needles",
// //     "Sewing Needles",
// //     "Embroidery Hoop",
// //     "Felt",
// //     "Fabric Scissors",
// //     "Yarn",
// //     "Knitting Needles",
// //     "Crochet Hook",
// //     "Mosaic Tiles",
// //     "Craft Glue",
// //     "Craft Paper Roll",
// //     "Paint Brushes",
// //     "Canvas",
// //     "Acrylic Paint",
// //     "Watercolors",
// //     "Oil Paint",
// //     "Pastels",
// //     "Colored Pencils",
// //     "Crayons",
// //     "Markers",
// //     "Charcoal",
// //     "Drawing Paper",
// //     "Sketching Paper",
// //     "Canvas Board",
// //     "Oil Pastels",
// //     "Watercolor Paper",
// //     "Paint Palette",
// //     "Acrylic Brushes",
// //     "Coloring Pencils",
// //     "Chalk",
// //     "Colored Chalk",
// //     "Chalkboard",
// //     "Chalk Eraser",
// //     "Glitter",
// //     "Glitter Glue",
// //     "Beads",
// //     "Feathers",
// //     "Gemstones",
// //     "Sequins",
// //     "Confetti",
// //     "Pipe Cleaners",
// //     "Pom-Poms",
// //     "Foam Sheets",
// //     "Craft Foam",
// //     "Canvas Bags",
// //     "Cotton Bags",
// //     "Tie-Dye Kit",
// //     "Stencils",
// //     "Markers",
// //     "Pastel Colors",
// //     "Crayon Sets",
// //     "Dry Erase Markers",
// //     "Easel",
// //     "Drawing Board",
// //     "Canvas Stretcher Bars",
// //     "Paint Set",
// //     "Watercolor Brushes",
// //     "Fine Liner Pens",
// //     "Art Sketchbook",
// //     "Art Paper",
// //     "Art Pencils",
// //     "Graphite Pencils",
// //     "Watercolor Pencils",
// //     "Artist Easel",
// //     "Palette Knives",
// //     "Stamping Tool",
// //     "Stamping Ink",
// //     "Paper Punch",
// //     "Scoring Tool",
// //     "Creasing Tool",
// //     "Embossing Tool",
// //     "Rubber Bands",
// //     "Paper Clips",
// //     "Clipboards",
// //     "Shredder",
// //     "Shredding Bags",
// //     "Staples",
// //     "Staple Gun",
// //     "Clipboard Holder",
// //     "Index Cards",
// //     "File Label Stickers",
// //     "Paper Labels",
// //     "Permanent Markers",
// //     "Chalk Markers",
// //     "Paint Pens",
// //     "Ink Pens",
// //     "Fountain Pens",
// //     "Ballpoint Pens",
// //     "Gel Pens",
// //     "Rollerball Pens",
// //     "Fineliner Pens",
// //     "Highlighters",
// //     "Colored Ink Pens",
// //     "Calligraphy Pens",
// //     "Brush Pens",
// //     "Mechanical Pencils",
// //     "Pencil Leads",
// //     "Pencil Refills",
// //     "Colored Pencils",
// //     "Watercolor Markers",
// //     "Wax Crayons",
// //     "Modeling Clay",
// //     "Air-Dry Clay",
// //     "Plasticine",
// //     "Play Dough",
// //     "Clay Tools",
// //     "Glue Gun",
// //     "Fabric Markers",
// //     "Fabric Paint",
// //     "Felt Tips",
// //     "Poster Board",
// //     "Bulletin Board",
// //     "Graph Paper Notebook",
// //     "Sketchbook",
// //     "Watercolor Set",
// //     "Erasable Markers",
// //     "Permanent Markers",
// //     "Stencil Sheets",
// //     "Graphing Calculator",
// //     "Protractor Set",
// //     "Ruler Set",
// //     "Compass Set",
// //     "Student Desk Organizer",
// //     "Pen Holder",
// //     "File Organizer",
// //     "Drawer Organizer",
// //     "Magazine Holders",
// //     "Storage Bins",
// //     "Rolling Cart",
// //     "Craft Cart",
// //     "Storage Box",
// //     "Wall Organizer",
// //     "Cork Board",
// //     "Whiteboard Eraser",
// //     "Classroom Posters",
// //     "Desk Clock",
// //     "Desktop Organizer",
// //     "Desk Tray",
// //     "Folder Labels",
// //     "Index Divider Labels",
// //     "Notebook Stickers",
// //     "Color Labels",
// //     "Ruler Stickers",
// //     "Envelope Stickers",
// //     "Pen Refills",
// //     "Stationery Kit",
// //     "Professional Stationery",
// //     "Luxury Pens",
// //     "Stationery Paper",
// //     "Personalized Stationery",
// //     "Greeting Cards",
// //     "Thank You Cards",
// //     "Invitation Cards",
// //     "Anniversary Cards",
// //     "Birthday Cards",
// //     "Wedding Invitations",
// //     "Stationery Sets",
// //     "Calligraphy Ink",
// //     "Calligraphy Pens",
// //     "Greeting Card Holder",
// //     "Gift Wrap",
// //     "Gift Bags",
// //     "Gift Tags",
// //     "Gift Ribbon",
// //     "Gift Tissue Paper",
// //     "Wrapping Paper",
// //     "Holiday Cards",
// //     "Christmas Cards",
// //     "Halloween Cards",
// //     "Valentine’s Day Cards",
// //     "Mother’s Day Cards",
// //     "Father’s Day Cards",
// //     "Greeting Card Box",
// //     "Postage Stamps",
// //     "Envelopes with Seal",
// //     "Postage Labels",
// //     "Personalized Stamps",
// //     "Custom Stationery",
// //     "Stationery Box",
// //     "Note Pads",
// //     "Memo Pads",
// //     "Desk Pads",
// //     "Sticky Notes",
// //     "Memo Stickers",
// //     "Calligraphy Brushes",
// //     "Fountain Ink",
// //     "Inkwell",
// //     "Travel Desk Organizer",
// //     "Clip-on Reading Light",
// //     "Desk Lamp",
// //     "Art Desk",
// //     "Craft Table",
// //     "Project Board",
// //     "Craft Paper Roll",
// //     "Bullet Journal",
// //     "Planner",
// //     "Diary",
// //     "To-Do List",
// //     "Organizer",
// //     "Task List",
// //     "Calendar",
// //     "Wall Calendar",
// //     "Desk Calendar",
// //     "Printable Planners",
// //     "Personal Planner",
// //     "Daily Planner",
// //     "Weekly Planner",
// //     "Monthly Planner",
// //     "Agenda",
// //     "Productivity Planner",
// //     "Life Planner",
// //     "Goal Planner",
// //     "Bullet Journal Stickers",
// //     "Planner Stickers",
// //     "Notebook Stickers",
// //     "File Divider Stickers",
// //     "Reminder Stickers",
// //     "Scheduling Stickers",
// //     "Business Planner",
// //     "Habit Tracker",
// //     "Vision Board",
// //     "Calendar Stickers",
// //     "Family Calendar",
// //     "Kids Planner",
// //     "School Planner",
// //     "Student Planner",
// //     "Work Planner",
// //     "Printable Calendar",
// //     "Turmeric",
// //     "Cumin",
// //     "Coriander",
// //     "Fennel",
// //     "Fenugreek",
// //     "Cardamom",
// //     "Clove",
// //     "Cinnamon",
// //     "Mustard Seeds",
// //     "Asafoetida (Hing)",
// //     "Chili Powder",
// //     "Garam Masala",
// //     "Tamarind",
// //     "Amchur (Dry Mango Powder)",
// //     "Kasuri Methi (Dried Fenugreek Leaves)",
// //     "Black Pepper",
// //     "Bay Leaves",
// //     "Ajwain (Carom Seeds)",
// //     "Poppy Seeds",
// //     "Nigella Seeds (Kalonji)",
// //     "Saffron",
// //     "Jaggery",
// //     "Curry Leaves",
// //     "Ginger Powder",
// //     "Garlic Powder",
// //     "Curry Powder",
// //     "Chaat Masala",
// //     "Tandoori Masala",
// //     "Panch Phoran",
// //     "Kala Namak (Black Salt)",
// //     "Rock Salt",
// //     "Salt",
// //     "Methi Seeds",
// //     "Kalonji (Nigella Seeds)",
// //     "Turmeric Root",
// //     "Curry Paste",
// //     "Chili Flakes",
// //     "Rosemary",
// //     "Thyme",
// //     "Mint",
// //     "Lemon Grass",
// //     "Mango Powder",
// //     "Cinnamon Sticks",
// //     "Star Anise",
// //     "Sichuan Pepper",
// //     "Aniseed",
// //     "Caraway Seeds",
// //     "Zaatar",
// //     "Tamarind Paste",
// //     "Szechuan Pepper",
// //     "Rasam Powder",
// //     "Tikka Masala",
// //     "Meethi Dana",
// //     "Chili Garlic Paste",
// //     "Methi Leaves",
// //     "Lemon Zest",
// //     "Sweet Lime",
// //     "Cinnamon Powder",
// //     "Clove Powder",
// //     "Dried Red Chilies",
// //     "Black Salt",
// //     "Sesame Seeds",
// //     "Coconut Powder",
// //     "Fried Onion",
// //     "Mace",
// //     "Javitri",
// //     "Pineapple Powder",
// //     "Rose Petals",
// //     "Bamboo Salt",
// //     "Shahi Jeera",
// //     "Kesar",
// //     "Kesar Powder",
// //     "Khoya",
// //     "Dry Ginger",
// //     "Long Pepper",
// //     "Coconut Oil",
// //     "Ghee",
// //     "Mustard Oil",
// //     "Vegetable Oil",
// //     "Peanut Oil",
// //     "Sesame Oil",
// //     "Mustard Powder",
// //     "Mango Pickle",
// //     "Garlic Chutney",
// //     "Chili Chutney",
// //     "Coconut Chutney",
// //     "Mint Chutney",
// //     "Tamarind Chutney",
// //     "Tomato Chutney",
// //     "Onion Chutney",
// //     "Chili Powder Mix",
// //     "Chana Masala",
// //     "Sambar Powder",
// //     "Methi Thepla",
// //     "Namak Pare",
// //     "Dosa Masala",
// //     "Biryani Masala",
// //     "Pulao Masala",
// //     "Khade Masale",
// //     "Pav Bhaji Masala",
// //     "Lassi Masala",
// //     "Vermicelli Masala",
// //     "Chatpati Masala",
// //     "Baking Powder",
// //     "Chili Sauce",
// //     "Coriander Seed Powder",
// //     "Jaggery Powder",
// //     "Dry Mango Powder",
// //     "Masala Tea Powder",
// //     "Tandoori Spice Mix",
// //     "Chutney Powder",
// //     "Sundal Powder",
// //     "Bhel Puri Masala",
// //     "Pudina Powder",
// //     "Chili Masala",
// //     "Sambhar Powder",
// //     "Idli Powder",
// //     "Sundal Masala",
// //     "Tamarind Concentrate",
// //     "Ginger Garlic Paste",
// //     "Almond Powder",
// //     "Rice Flour",
// //     "Rice Bran Oil",
// //     "Soya Sauce",
// //     "Tamarind Concentrate",
// //     "Curry Leaf Powder",
// //     "Hing Powder",
// //     "Tamarind Concentrate",
// //     "Pista Powder",
// //     "Cashew Powder",
// //     "Pineapple Masala",
// //     "Jowar Flour",
// //     "Ragi Flour",
// //     "Milling Masala",
// //     "Wheat Flour",
// //     "Kuttu Flour",
// //     "Sattu",
// //     "Millet Flour",
// //     "Barley Flour",
// //     "Fenugreek Leaves",
// //     "Curry Masala",
// //     "Pudina Masala",
// //     "Carom Seeds",
// //     "Cheese Powder",
// //     "Moong Dal Masala",
// //     "Fried Gram Flour",
// //     "Garlic Chutney Powder",
// //     "Roasted Methi Powder",
// //     "Dried Ginger Powder",
// //     "Whole Wheat Flour",
// //     "Rice Bran Powder",
// //     "Cucumber Powder",
// //     "Rose Petal Powder",
// //     "Curry Blossom Powder",
// //     "Sesame Powder",
// //     "Cumin Powder",
// //     "Coriander Powder",
// //     "Cabbage Powder",
// //     "Amla Powder",
// //     "Dried Mango Powder",
// //     "Chili Lime Powder",
// //     "Tomato Powder",
// //     "Curry Powder Mix",
// //     "Cucumber Chutney",
// //     "Jeera Powder",
// //     "Pulses Masala",
// //     "Cumin Seed Powder",
// //     "Turmeric Seed",
// //     "Curry Flower",
// //     "Curry Powder",
// //     "Garlic Masala",
// //     "Cumin Seed",
// //     "Cardamom Powder",
// //     "Chili Pepper",
// //     "Curry Spice",
// //     "Pineapple Spice",
// //     "Soya Sauce Powder",
// //     "Dry Curry Powder",
// //     "Ajwain Powder",
// //     "Cardamom Seeds",
// //     "Pumpkin Seeds",
// //     "Sunflower Seeds",
// //     "Watermelon Seeds",
// //     "Coriander Seed",
// //     "Oregano",
// //     "Curry Paste",
// //     "Garlic Chutney Mix",
// //     "Dried Lemongrass",
// //     "Rosemary Powder",
// //     "Paprika",
// //     "Coconut Grated",
// //     "Coconut Powder",
// //     "Sesame Chutney",
// //     "Mint Paste",
// //     "Ginger Chutney",
// //     "Cinnamon Oil",
// //     "Coconut Milk",
// //     "Masala Pepper",
// //     "Gravy Masala",
// //     "Saag Masala",
// //     "Ginger Paste",
// //     "Tomato Paste",
// //     "Ajwain Seeds",
// //     "Kalpasi",
// //     "Chili Paste",
// //     "Tamarind Salt",
// //     "Fennel Seed Powder",
// //     "Flax Seeds",
// //     "Cucumber Masala",
// //     "Cardamom Pods",
// //     "Ginger Masala",
// //     "Fennel Seed Masala",
// //     "Coconut Water",
// //     "Sambar Masala",
// //     "Pumpkin Spice",
// //     "Dried Fennel",
// //     "Clove Oil",
// //     "Black Peppercorns",
// //     "Curry Leaf",
// //     "Methi Seed",
// //     "Khadi Masala",
// //     "Chana Masala",
// //     "Peanut Masala",
// //     "Basil Seeds",
// //     "Jaggery",
// //     "Vinegar",
// //     "Molasses",
// //     "Rice Bran",
// //     "Peach Powder",
// //     "Apricot Powder",
// //     "Rose Syrup",
// //     "Saffron Essence",
// //     "Cardamom Essence",
// //     "Poppy Seed Oil",
// //     "Corn Starch",
// //     "Rasam Masala",
// //     "Garlic Masala Powder",
// //     "Chili Ginger Sauce",
// //     "Biryani Masala Powder",
// //     "Pineapple Ginger Masala",
// //     "Dry Chutney Mix",
// //     "Sandalwood Powder",
// //     "Cumin Powder",
// //     "Rasam Powder",
// //     "Fresh Turmeric",
// //     "Hing Extract",
// //     "Saffron Powder",
// //     "Curry Leaf Extract",
// //     "Fennel Extract",
// //     "Chili Oil",
// //     "Olive Oil",
// //     "Curry Masala Mix",
// //   ];

// //   // Debouncer for onChanged
// //   final _debouncer = Debouncer(milliseconds: 300);

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialize Trie with grocery items
// //     for (var item in groceryItems) {
// //       _trie.insert(item.toLowerCase());
// //     }
// //     _fetchAllTeamData();
// //   }

// //   Future<void> _fetchAllTeamData() async {
// //     final user = _currentUser;
// //     if (user == null) {
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     try {
// //       print('[DEBUG] Fetching teams for user: ${user.uid}');
// //       final currentTeamsSnapshot = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(user.uid)
// //           .collection('current_teams')
// //           .get();

// //       final teamData = <String, Map<String, dynamic>>{};
// //       final teamItems = <String, List<QueryDocumentSnapshot>>{};

// //       for (final doc in currentTeamsSnapshot.docs) {
// //         final data = doc.data();
// //         teamData[doc.id] = {
// //           'teamId': doc.id,
// //           'name': data['name'] ?? 'Unnamed Team',
// //           'isSelf': false,
// //         };
// //       }

// //       final selfTeamSnapshot = await FirebaseFirestore.instance
// //           .collection('teams')
// //           .where('admin', isEqualTo: user.uid)
// //           .where('isSelf', isEqualTo: true)
// //           .get();

// //       if (selfTeamSnapshot.docs.isNotEmpty) {
// //         final selfTeam = selfTeamSnapshot.docs.first;
// //         final selfTeamId = selfTeam.id;
// //         if (!teamData.containsKey(selfTeamId)) {
// //           teamData[selfTeamId] = {
// //             'teamId': selfTeamId,
// //             'name': selfTeam['name'] ?? 'Self',
// //             'isSelf': true,
// //           };
// //         }
// //       }

// //       for (final teamId in teamData.keys) {
// //         final itemsSnapshot = await FirebaseFirestore.instance
// //             .collection('teams')
// //             .doc(teamId)
// //             .collection('self_items')
// //             .get();
// //         teamItems[teamId] = itemsSnapshot.docs;
// //       }

// //       setState(() {
// //         _teamData = teamData;
// //         _teamItems = teamItems;
// //         _isLoading = false;
// //       });
// //       print('[DEBUG] Fetched ${teamData.length} teams');
// //     } catch (e) {
// //       print('[ERROR] Error fetching team data: $e');
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
// //     setState(() {
// //       if (_expandedTeamId == teamId) {
// //         _expandedTeamId = null;
// //       } else {
// //         _expandedTeamId = teamId;
// //         TeamManager().setCurrentTeam(teamId, teamName, context);
// //       }
// //     });
// //   }

// //   double _calculateEstimatedCost(String teamId) {
// //     final items = _teamItems[teamId] ?? [];
// //     return items.fold(0.0, (sum, doc) {
// //       final data = doc.data() as Map<String, dynamic>;
// //       final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
// //       final price = double.tryParse(priceStr) ?? 0.0;
// //       return sum + price;
// //     });
// //   }

// //   Widget _buildAddItem(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         _showAddItemDialog(context);
// //       },
// //       child: Container(
// //         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
// //         padding: EdgeInsets.all(10),
// //         decoration: BoxDecoration(
// //           color: Colors.blue[100],
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Icon(Icons.add, color: Colors.blue[600]),
// //             SizedBox(width: 10),
// //             Text(
// //               'Add Item',
// //               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildListItem(
// //     String docId,
// //     String itemName,
// //     String quantity,
// //     bool isDone,
// //     String price,
// //   ) {
// //     final textLength = (itemName + quantity).length;
// //     final containerHeight = textLength > 20 ? 80.0 : 60.0;
// //     final maxItemNameLength = 10;
// //     final truncatedItemName = itemName.length > maxItemNameLength
// //         ? '${itemName.substring(0, maxItemNameLength)}...'
// //         : itemName;

// //     return Container(
// //       margin: EdgeInsets.only(bottom: 10),
// //       height: containerHeight,
// //       padding: EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: isDone ? Colors.green[200] : Colors.blue[100],
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Checkbox(
// //             value: isDone,
// //             onChanged: (value) async {
// //               if (value == null) return;
// //               final currentUserId = _currentUser?.uid;
// //               if (currentUserId == null) return;

// //               try {
// //                 final itemRef = FirebaseFirestore.instance
// //                     .collection('teams')
// //                     .doc(TeamManager().currentTeamId)
// //                     .collection('self_items')
// //                     .doc(docId);
// //                 final itemSnap = await itemRef.get();
// //                 final data = itemSnap.data() as Map<String, dynamic>;
// //                 final lastCheckedBy = data['checked_by'] ?? '';

// //                 if (value && !isDone) {
// //                   await itemRef.update({
// //                     'is_done': true,
// //                     'edit_time': Timestamp.now(),
// //                     'is_edited': true,
// //                     'checked_by': currentUserId,
// //                   });
// //                 } else if (!value && isDone) {
// //                   if (lastCheckedBy == currentUserId) {
// //                     await itemRef.update({
// //                       'is_done': false,
// //                       'edit_time': Timestamp.now(),
// //                       'is_edited': true,
// //                       'checked_by': null,
// //                     });
// //                   } else {
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       SnackBar(
// //                         content: Text(
// //                           'Only the user who checked can uncheck this item.',
// //                         ),
// //                       ),
// //                     );
// //                     return;
// //                   }
// //                 }
// //                 _fetchAllTeamData();
// //               } catch (e) {
// //                 print('[ERROR] Error updating is_done: $e');
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Error updating item: $e')),
// //                 );
// //               }
// //             },
// //           ),
// //           Expanded(
// //             child: Text(
// //               '$truncatedItemName - $quantity',
// //               style: TextStyle(
// //                 decoration: isDone
// //                     ? TextDecoration.lineThrough
// //                     : TextDecoration.none,
// //                 fontSize: 16,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ),
// //           SizedBox(width: 10),
// //           Text('$price', style: TextStyle(fontSize: 14, color: Colors.black)),
// //           if (!isDone)
// //             Row(
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.edit, size: 20),
// //                   onPressed: () {
// //                     _showEditItemDialog(
// //                       context,
// //                       docId,
// //                       itemName,
// //                       quantity,
// //                       price,
// //                     );
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.delete, size: 20),
// //                   onPressed: () {
// //                     _deleteItemFromFirestore(
// //                       context,
// //                       docId,
// //                       itemName,
// //                       quantity,
// //                       isDone,
// //                       price,
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _addItemToFirestore(String itemName, String quantity) async {
// //     try {
// //       final user = _currentUser;
// //       final userName = user?.displayName ?? user?.email ?? 'Unknown';
// //       final teamId = TeamManager().currentTeamId;
// //       print(
// //         '[DEBUG] Adding item to Firestore: $itemName, quantity: $quantity, teamId: $teamId',
// //       );
// //       await FirebaseFirestore.instance
// //           .collection('teams')
// //           .doc(teamId)
// //           .collection('self_items')
// //           .add({
// //             'add_time': Timestamp.now(),
// //             'assigned_by': userName,
// //             'bought_by': userName,
// //             'edit_time': null,
// //             'is_done': false,
// //             'is_edited': false,
// //             'item_name': itemName,
// //             'price': 'Rs. 299',
// //             'quantity': quantity,
// //             'checked_by': null,
// //           });
// //       print('[DEBUG] Firestore write succeeded for teamId: $teamId');
// //       _fetchAllTeamData();
// //     } catch (e) {
// //       print('[ERROR] Error adding item to Firestore: $e');
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Error adding item: $e')));
// //     }
// //   }

// //   void _showAddItemDialog(BuildContext context) {
// //     String itemName = '';
// //     String quantity = '';
// //     List<String> suggestions = [];
// //     final itemNameController = TextEditingController();
// //     final quantityController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return Dialog(
// //           backgroundColor: Colors.transparent,
// //           child: StatefulBuilder(
// //             builder: (context, setState) {
// //               return Container(
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [Colors.blue[900]!, Colors.blue[200]!],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.all(Radius.circular(10)),
// //                 ),
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(
// //                       'Add New Item',
// //                       style: TextStyle(fontSize: 20, color: Colors.white),
// //                     ),
// //                     SizedBox(height: 16),
// //                     TextField(
// //                       controller: itemNameController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Item Name',
// //                         labelStyle: TextStyle(color: Colors.white),
// //                         prefixIcon: Icon(
// //                           Icons.shopping_cart,
// //                           color: Colors.white,
// //                         ),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                       ),
// //                       style: TextStyle(color: Colors.white),
// //                       onChanged: (value) {
// //                         itemName = value;
// //                         _debouncer.run(() {
// //                           setState(() {
// //                             suggestions = _trie.getSuggestions(
// //                               value.toLowerCase(),
// //                             );
// //                             print(
// //                               '[DEBUG] Filtering suggestions for query: $value',
// //                             );
// //                             print('[DEBUG] Suggestions: $suggestions');
// //                           });
// //                         });
// //                       },
// //                     ),
// //                     if (suggestions.isNotEmpty)
// //                       Container(
// //                         constraints: BoxConstraints(maxHeight: 150),
// //                         child: ListView.builder(
// //                           shrinkWrap: true,
// //                           itemCount: suggestions.length,
// //                           itemBuilder: (context, index) {
// //                             final suggestion = suggestions[index];
// //                             return ListTile(
// //                               title: Text(
// //                                 suggestion,
// //                                 style: TextStyle(color: Colors.black),
// //                               ),
// //                               onTap: () {
// //                                 itemNameController.text = suggestion;
// //                                 itemName = suggestion;
// //                                 setState(() {
// //                                   suggestions = [];
// //                                   print(
// //                                     '[DEBUG] Selected suggestion: $suggestion',
// //                                   );
// //                                 });
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     SizedBox(height: 16),
// //                     TextField(
// //                       controller: quantityController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Quantity',
// //                         labelStyle: TextStyle(color: Colors.white),
// //                         prefixIcon: Icon(Icons.numbers, color: Colors.white),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                       ),
// //                       style: TextStyle(color: Colors.white),
// //                       onChanged: (value) {
// //                         quantity = value;
// //                       },
// //                     ),
// //                     SizedBox(height: 16),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         if (itemName.isNotEmpty && quantity.isNotEmpty) {
// //                           _addItemToFirestore(itemName, quantity);
// //                           Navigator.pop(context);
// //                         } else {
// //                           ScaffoldMessenger.of(context).showSnackBar(
// //                             SnackBar(content: Text('Please fill both fields')),
// //                           );
// //                         }
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: Colors.blue[900],
// //                       ),
// //                       child: Text('Add Item'),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showEditItemDialog(
// //     BuildContext context,
// //     String docId,
// //     String itemName,
// //     String quantity,
// //     String price,
// //   ) {
// //     String editedItemName = itemName;
// //     String editedQuantity = quantity;
// //     List<String> suggestions = [];
// //     final itemNameController = TextEditingController(text: itemName);
// //     final quantityController = TextEditingController(text: quantity);

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return Dialog(
// //           backgroundColor: Colors.transparent,
// //           child: StatefulBuilder(
// //             builder: (context, setState) {
// //               return Container(
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [Colors.blue[900]!, Colors.blue[200]!],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.all(Radius.circular(10)),
// //                 ),
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(
// //                       'Edit Item',
// //                       style: TextStyle(fontSize: 20, color: Colors.white),
// //                     ),
// //                     SizedBox(height: 16),
// //                     TextField(
// //                       controller: itemNameController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Item Name',
// //                         labelStyle: TextStyle(color: Colors.white),
// //                         prefixIcon: Icon(
// //                           Icons.shopping_cart,
// //                           color: Colors.white,
// //                         ),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                       ),
// //                       style: TextStyle(color: Colors.white),
// //                       onChanged: (value) {
// //                         editedItemName = value;
// //                         _debouncer.run(() {
// //                           setState(() {
// //                             suggestions = _trie.getSuggestions(
// //                               value.toLowerCase(),
// //                             );
// //                             print(
// //                               '[DEBUG] Filtering suggestions for query: $value',
// //                             );
// //                             print('[DEBUG] Suggestions: $suggestions');
// //                           });
// //                         });
// //                       },
// //                     ),
// //                     if (suggestions.isNotEmpty)
// //                       Container(
// //                         constraints: BoxConstraints(maxHeight: 150),
// //                         child: ListView.builder(
// //                           shrinkWrap: true,
// //                           itemCount: suggestions.length,
// //                           itemBuilder: (context, index) {
// //                             final suggestion = suggestions[index];
// //                             return ListTile(
// //                               title: Text(
// //                                 suggestion,
// //                                 style: TextStyle(color: Colors.black),
// //                               ),
// //                               onTap: () {
// //                                 itemNameController.text = suggestion;
// //                                 editedItemName = suggestion;
// //                                 setState(() {
// //                                   suggestions = [];
// //                                   print(
// //                                     '[DEBUG] Selected suggestion: $suggestion',
// //                                   );
// //                                 });
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     SizedBox(height: 16),
// //                     TextField(
// //                       controller: quantityController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Quantity',
// //                         labelStyle: TextStyle(color: Colors.white),
// //                         prefixIcon: Icon(Icons.numbers, color: Colors.white),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                         focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.white),
// //                         ),
// //                       ),
// //                       style: TextStyle(color: Colors.white),
// //                       onChanged: (value) {
// //                         editedQuantity = value;
// //                       },
// //                     ),
// //                     SizedBox(height: 16),
// //                     ElevatedButton(
// //                       onPressed: () async {
// //                         if (editedItemName.isNotEmpty &&
// //                             editedQuantity.isNotEmpty) {
// //                           try {
// //                             print(
// //                               '[DEBUG] Updating item: $editedItemName, quantity: $editedQuantity, docId: $docId',
// //                             );
// //                             await FirebaseFirestore.instance
// //                                 .collection('teams')
// //                                 .doc(TeamManager().currentTeamId)
// //                                 .collection('self_items')
// //                                 .doc(docId)
// //                                 .update({
// //                                   'item_name': editedItemName,
// //                                   'quantity': editedQuantity,
// //                                   'edit_time': Timestamp.now(),
// //                                   'is_edited': true,
// //                                 });
// //                             print(
// //                               '[DEBUG] Firestore update succeeded for docId: $docId',
// //                             );
// //                             Navigator.pop(context);
// //                             _fetchAllTeamData();
// //                           } catch (e) {
// //                             print('[ERROR] Error editing item: $e');
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(content: Text('Error editing item: $e')),
// //                             );
// //                           }
// //                         } else {
// //                           ScaffoldMessenger.of(context).showSnackBar(
// //                             SnackBar(content: Text('Please fill both fields')),
// //                           );
// //                         }
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: Colors.blue[900],
// //                       ),
// //                       child: Text('Save Changes'),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _deleteItemFromFirestore(
// //     BuildContext context,
// //     String docId,
// //     String itemName,
// //     String quantity,
// //     bool isDone,
// //     String price,
// //   ) async {
// //     try {
// //       final deletedItem = {
// //         'add_time': Timestamp.now(),
// //         'assigned_by':
// //             _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// //         'bought_by':
// //             _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
// //         'edit_time': null,
// //         'is_done': isDone,
// //         'is_edited': false,
// //         'item_name': itemName,
// //         'price': price,
// //         'quantity': quantity,
// //       };

// //       print('[DEBUG] Deleting item: $itemName, docId: $docId');
// //       await FirebaseFirestore.instance
// //           .collection('teams')
// //           .doc(TeamManager().currentTeamId)
// //           .collection('self_items')
// //           .doc(docId)
// //           .delete();

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Item "$itemName" deleted'),
// //           action: SnackBarAction(
// //             label: 'Undo',
// //             onPressed: () async {
// //               try {
// //                 await FirebaseFirestore.instance
// //                     .collection('teams')
// //                     .doc(TeamManager().currentTeamId)
// //                     .collection('self_items')
// //                     .add(deletedItem);
// //                 print('[DEBUG] Undo delete succeeded for item: $itemName');
// //                 _fetchAllTeamData();
// //               } catch (e) {
// //                 print('[ERROR] Error undoing delete: $e');
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Error undoing delete: $e')),
// //                 );
// //               }
// //             },
// //           ),
// //           duration: Duration(seconds: 5),
// //         ),
// //       );
// //       _fetchAllTeamData();
// //     } catch (e) {
// //       print('[ERROR] Error deleting item: $e');
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Error deleting item: $e')));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: _scaffoldKey,
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Column(
// //             children: [
// //               GreetWidget(),
// //               Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                 child: TextField(
// //                   decoration: InputDecoration(
// //                     hintText: 'Search',
// //                     prefixIcon: Icon(Icons.search),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //               Expanded(
// //                 child: _isLoading
// //                     ? Center(child: CircularProgressIndicator())
// //                     : _teamData.isEmpty
// //                     ? Center(child: Text('No gatherings yet'))
// //                     : ListView.builder(
// //                         padding: EdgeInsets.all(16.0),
// //                         itemCount: _teamData.length,
// //                         itemBuilder: (context, index) {
// //                           final teamId = _teamData.keys.elementAt(index);
// //                           final team = _teamData[teamId]!;
// //                           final teamName = team['name'] as String;
// //                           final isSelf = team['isSelf'] as bool;
// //                           final items = _teamItems[teamId] ?? [];
// //                           final estimatedCost = _calculateEstimatedCost(teamId);
// //                           return Column(
// //                             children: [
// //                               GestureDetector(
// //                                 onTap: () => _toggleTeamExpansion(
// //                                   teamId,
// //                                   teamName,
// //                                   isSelf,
// //                                 ),
// //                                 child: Container(
// //                                   padding: EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     boxShadow: [
// //                                       BoxShadow(
// //                                         color: Colors.grey.withOpacity(0.3),
// //                                         spreadRadius: 2,
// //                                         blurRadius: 5,
// //                                         offset: Offset(0, 3),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Text(
// //                                         teamName,
// //                                         style: TextStyle(
// //                                           fontSize: 16,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                       Icon(
// //                                         _expandedTeamId == teamId
// //                                             ? Icons.expand_less
// //                                             : Icons.expand_more,
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               AnimatedSize(
// //                                 duration: Duration(milliseconds: 300),
// //                                 curve: Curves.easeInOut,
// //                                 child: _expandedTeamId == teamId
// //                                     ? Container(
// //                                         padding: EdgeInsets.all(16),
// //                                         child: SingleChildScrollView(
// //                                           child: Column(
// //                                             children: [
// //                                               Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text(
// //                                                     'Grocery List',
// //                                                     style: TextStyle(
// //                                                       fontSize: 14,
// //                                                       color: Colors.grey,
// //                                                     ),
// //                                                   ),
// //                                                   Text(
// //                                                     'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
// //                                                     style: TextStyle(
// //                                                       fontSize: 14,
// //                                                       color: Colors.black,
// //                                                     ),
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                               SizedBox(height: 8),
// //                                               _buildAddItem(context),
// //                                               Column(
// //                                                 children: items.map<Widget>((
// //                                                   doc,
// //                                                 ) {
// //                                                   final data =
// //                                                       doc.data()
// //                                                           as Map<
// //                                                             String,
// //                                                             dynamic
// //                                                           >;
// //                                                   final docId = doc.id;
// //                                                   final itemName =
// //                                                       data['item_name'] ?? '';
// //                                                   final quantity =
// //                                                       data['quantity'] ?? '';
// //                                                   final isDone =
// //                                                       data['is_done'] ?? false;
// //                                                   final price =
// //                                                       data['price'] ?? 'Rs. 0';
// //                                                   return _buildListItem(
// //                                                     docId,
// //                                                     itemName,
// //                                                     quantity,
// //                                                     isDone,
// //                                                     price,
// //                                                   );
// //                                                 }).toList(),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       )
// //                                     : SizedBox.shrink(),
// //                               ),
// //                               SizedBox(height: 16),
// //                             ],
// //                           );
// //                         },
// //                       ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           try {
// //             setState(() {
// //               _micActive = !_micActive;
// //             });
// //             if (_micActive) {
// //               _micService.setListening(true);
// //               _micService.showVoiceInputDialog(
// //                 context,
// //                 () {
// //                   if (_micService.intent == 'add' &&
// //                       _micService.name != null &&
// //                       _micService.quantity != null) {
// //                     _addItemToFirestore(
// //                       _micService.name!,
// //                       _micService.quantity!,
// //                     );
// //                   }
// //                 },
// //                 () {
// //                   setState(() {
// //                     _micActive = false;
// //                   });
// //                 },
// //               );
// //             } else {
// //               _micService.setListening(false);
// //             }
// //           } catch (e) {
// //             print('[ERROR] MicService error: $e');
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('Error with mic service: $e')),
// //             );
// //           }
// //         },
// //         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
// //         elevation: 6.0,
// //         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
// //     );
// //   }
// // }

// // // TrieNode class
// // class TrieNode {
// //   Map<String, TrieNode> children = {};
// //   bool isEndOfWord = false;
// // }

// // // Trie class
// // class Trie {
// //   TrieNode root = TrieNode();

// //   // Insert a word into the Trie
// //   void insert(String word) {
// //     TrieNode node = root;
// //     for (int i = 0; i < word.length; i++) {
// //       String letter = word[i];
// //       if (!node.children.containsKey(letter)) {
// //         node.children[letter] = TrieNode();
// //       }
// //       node = node.children[letter]!;
// //     }
// //     node.isEndOfWord = true;
// //   }

// //   // Get suggestions based on a prefix
// //   List<String> getSuggestions(String prefix) {
// //     TrieNode node = root;
// //     for (int i = 0; i < prefix.length; i++) {
// //       String letter = prefix[i];
// //       if (!node.children.containsKey(letter)) return [];
// //       node = node.children[letter]!;
// //     }
// //     return _getWords(node, prefix);
// //   }

// //   // Helper method to get all words from a node
// //   List<String> _getWords(TrieNode node, String prefix) {
// //     List<String> words = [];
// //     if (node.isEndOfWord) words.add(prefix);
// //     for (var letter in node.children.keys) {
// //       _getWords(node.children[letter]!, prefix + letter).forEach(words.add);
// //     }
// //     return words;
// //   }
// // }

// // // Debouncer class to limit setState calls
// // class Debouncer {
// //   final int milliseconds;
// //   VoidCallback? _action;
// //   Timer? _timer;

// //   Debouncer({required this.milliseconds});

// //   void run(VoidCallback action) {
// //     _timer?.cancel();
// //     _timer = Timer(Duration(milliseconds: milliseconds), action);
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:groz2/service/suggestion.dart';
// import 'dart:async';
// import '../service/mic.dart';
// import '../widgets/greet.dart';
// import '../service/handle_teams.dart';


// class ListingPage extends StatefulWidget {
//   const ListingPage({super.key});

//   @override
//   _ListingPageState createState() => _ListingPageState();
// }

// class _ListingPageState extends State<ListingPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final MicService _micService = MicService();
//   bool _micActive = false;
//   Map<String, Map<String, dynamic>> _teamData = {};
//   Map<String, List<QueryDocumentSnapshot>> _teamItems = {};
//   String? _expandedTeamId;
//   bool _isLoading = true;
//   final User? _currentUser = FirebaseAuth.instance.currentUser;
//   final Trie _trie = Trie(); // Trie is now initialized with groceryItems in its constructor

//   // Debouncer for onChanged
//   final _debouncer = Debouncer(milliseconds: 300);

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllTeamData();
//   }

//   Future<void> _fetchAllTeamData() async {
//     final user = _currentUser;
//     if (user == null) {
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       print('[DEBUG] Fetching teams for user: ${user.uid}');
//       final currentTeamsSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('current_teams')
//           .get();

//       final teamData = <String, Map<String, dynamic>>{};
//       final teamItems = <String, List<QueryDocumentSnapshot>>{};

//       for (final doc in currentTeamsSnapshot.docs) {
//         final data = doc.data();
//         teamData[doc.id] = {
//           'teamId': doc.id,
//           'name': data['name'] ?? 'Unnamed Team',
//           'isSelf': false,
//         };
//       }

//       final selfTeamSnapshot = await FirebaseFirestore.instance
//           .collection('teams')
//           .where('admin', isEqualTo: user.uid)
//           .where('isSelf', isEqualTo: true)
//           .get();

//       if (selfTeamSnapshot.docs.isNotEmpty) {
//         final selfTeam = selfTeamSnapshot.docs.first;
//         final selfTeamId = selfTeam.id;
//         if (!teamData.containsKey(selfTeamId)) {
//           teamData[selfTeamId] = {
//             'teamId': selfTeamId,
//             'name': selfTeam['name'] ?? 'Self',
//             'isSelf': true,
//           };
//         }
//       }

//       for (final teamId in teamData.keys) {
//         final itemsSnapshot = await FirebaseFirestore.instance
//             .collection('teams')
//             .doc(teamId)
//             .collection('self_items')
//             .get();
//         teamItems[teamId] = itemsSnapshot.docs;
//       }

//       setState(() {
//         _teamData = teamData;
//         _teamItems = teamItems;
//         _isLoading = false;
//       });
//       print('[DEBUG] Fetched ${teamData.length} teams');
//     } catch (e) {
//       print('[ERROR] Error fetching team data: $e');
//       setState(() => _isLoading = false);
//     }
//   }

//   void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
//     setState(() {
//       if (_expandedTeamId == teamId) {
//         _expandedTeamId = null;
//       } else {
//         _expandedTeamId = teamId;
//         TeamManager().setCurrentTeam(teamId, teamName, context);
//       }
//     });
//   }

//   double _calculateEstimatedCost(String teamId) {
//     final items = _teamItems[teamId] ?? [];
//     return items.fold(0.0, (sum, doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
//       final price = double.tryParse(priceStr) ?? 0.0;
//       return sum + price;
//     });
//   }

//   Widget _buildAddItem(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _showAddItemDialog(context);
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.blue[100],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(Icons.add, color: Colors.blue[600]),
//             SizedBox(width: 10),
//             Text(
//               'Add Item',
//               style: TextStyle(fontSize: 16, color: Colors.blue[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildListItem(
//     String docId,
//     String itemName,
//     String quantity,
//     bool isDone,
//     String price,
//   ) {
//     final textLength = (itemName + quantity).length;
//     final containerHeight = textLength > 20 ? 80.0 : 60.0;
//     final maxItemNameLength = 10;
//     final truncatedItemName = itemName.length > maxItemNameLength
//         ? '${itemName.substring(0, maxItemNameLength)}...'
//         : itemName;

//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       height: containerHeight,
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: isDone ? Colors.green[200] : Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Checkbox(
//             value: isDone,
//             onChanged: (value) async {
//               if (value == null) return;
//               final currentUserId = _currentUser?.uid;
//               if (currentUserId == null) return;

//               try {
//                 final itemRef = FirebaseFirestore.instance
//                     .collection('teams')
//                     .doc(TeamManager().currentTeamId)
//                     .collection('self_items')
//                     .doc(docId);
//                 final itemSnap = await itemRef.get();
//                 final data = itemSnap.data() as Map<String, dynamic>;
//                 final lastCheckedBy = data['checked_by'] ?? '';

//                 if (value && !isDone) {
//                   await itemRef.update({
//                     'is_done': true,
//                     'edit_time': Timestamp.now(),
//                     'is_edited': true,
//                     'checked_by': currentUserId,
//                   });
//                 } else if (!value && isDone) {
//                   if (lastCheckedBy == currentUserId) {
//                     await itemRef.update({
//                       'is_done': false,
//                       'edit_time': Timestamp.now(),
//                       'is_edited': true,
//                       'checked_by': null,
//                     });
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Only the user who checked can uncheck this item.')),
//                     );
//                     return;
//                   }
//                 }
//                 _fetchAllTeamData();
//               } catch (e) {
//                 print('[ERROR] Error updating is_done: $e');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error updating item: $e')),
//                 );
//               }
//             },
//           ),
//           Expanded(
//             child: Text(
//               '$truncatedItemName - $quantity',
//               style: TextStyle(
//                 decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(width: 10),
//           Text(
//             '$price',
//             style: TextStyle(fontSize: 14, color: Colors.black),
//           ),
//           if (!isDone)
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit, size: 20),
//                   onPressed: () {
//                     _showEditItemDialog(context, docId, itemName, quantity, price);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete, size: 20),
//                   onPressed: () {
//                     _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   void _addItemToFirestore(String itemName, String quantity) async {
//     try {
//       final user = _currentUser;
//       final userName = user?.displayName ?? user?.email ?? 'Unknown';
//       final teamId = TeamManager().currentTeamId;
//       print('[DEBUG] Adding item to Firestore: $itemName, quantity: $quantity, teamId: $teamId');
//       await FirebaseFirestore.instance
//           .collection('teams')
//           .doc(teamId)
//           .collection('self_items')
//           .add({
//         'add_time': Timestamp.now(),
//         'assigned_by': userName,
//         'bought_by': userName,
//         'edit_time': null,
//         'is_done': false,
//         'is_edited': false,
//         'item_name': itemName,
//         'price': 'Rs. 299',
//         'quantity': quantity,
//         'checked_by': null,
//       });
//       print('[DEBUG] Firestore write succeeded for teamId: $teamId');
//       _fetchAllTeamData();
//     } catch (e) {
//       print('[ERROR] Error adding item to Firestore: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error adding item: $e')),
//       );
//     }
//   }

//   void _showAddItemDialog(BuildContext context) {
//     String itemName = '';
//     String quantity = '';
//     List<String> suggestions = [];
//     final itemNameController = TextEditingController();
//     final quantityController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue[900]!, Colors.blue[200]!],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Add New Item',
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: itemNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Item Name',
//                         labelStyle: TextStyle(color: Colors.white),
//                         prefixIcon: Icon(Icons.shopping_cart, color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                       onChanged: (value) {
//                         itemName = value;
//                         _debouncer.run(() {
//                           setState(() {
//                             suggestions = _trie.getSuggestions(value.toLowerCase());
//                             print('[DEBUG] Filtering suggestions for query: $value');
//                             print('[DEBUG] Suggestions: $suggestions');
//                           });
//                         });
//                       },
//                     ),
//                     if (suggestions.isNotEmpty)
//                       Container(
//                         constraints: BoxConstraints(maxHeight: 150),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: suggestions.length,
//                           itemBuilder: (context, index) {
//                             final suggestion = suggestions[index];
//                             return ListTile(
//                               title: Text(
//                                 suggestion,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               onTap: () {
//                                 itemNameController.text = suggestion;
//                                 itemName = suggestion;
//                                 setState(() {
//                                   suggestions = [];
//                                   print('[DEBUG] Selected suggestion: $suggestion');
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: quantityController,
//                       decoration: InputDecoration(
//                         labelText: 'Quantity',
//                         labelStyle: TextStyle(color: Colors.white),
//                         prefixIcon: Icon(Icons.numbers, color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                       onChanged: (value) {
//                         quantity = value;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (itemName.isNotEmpty && quantity.isNotEmpty) {
//                           _addItemToFirestore(itemName, quantity);
//                           Navigator.pop(context);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Please fill both fields')),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.blue[900],
//                       ),
//                       child: Text('Add Item'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
//     String editedItemName = itemName;
//     String editedQuantity = quantity;
//     List<String> suggestions = [];
//     final itemNameController = TextEditingController(text: itemName);
//     final quantityController = TextEditingController(text: quantity);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue[900]!, Colors.blue[200]!],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Edit Item',
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: itemNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Item Name',
//                         labelStyle: TextStyle(color: Colors.white),
//                         prefixIcon: Icon(Icons.shopping_cart, color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                       onChanged: (value) {
//                         editedItemName = value;
//                         _debouncer.run(() {
//                           setState(() {
//                             suggestions = _trie.getSuggestions(value.toLowerCase());
//                             print('[DEBUG] Filtering suggestions for query: $value');
//                             print('[DEBUG] Suggestions: $suggestions');
//                           });
//                         });
//                       },
//                     ),
//                     if (suggestions.isNotEmpty)
//                       Container(
//                         constraints: BoxConstraints(maxHeight: 150),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: suggestions.length,
//                           itemBuilder: (context, index) {
//                             final suggestion = suggestions[index];
//                             return ListTile(
//                               title: Text(
//                                 suggestion,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               onTap: () {
//                                 itemNameController.text = suggestion;
//                                 editedItemName = suggestion;
//                                 setState(() {
//                                   suggestions = [];
//                                   print('[DEBUG] Selected suggestion: $suggestion');
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: quantityController,
//                       decoration: InputDecoration(
//                         labelText: 'Quantity',
//                         labelStyle: TextStyle(color: Colors.white),
//                         prefixIcon: Icon(Icons.numbers, color: Colors.white),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                       onChanged: (value) {
//                         editedQuantity = value;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
//                           try {
//                             print('[DEBUG] Updating item: $editedItemName, quantity: $editedQuantity, docId: $docId');
//                             await FirebaseFirestore.instance
//                                 .collection('teams')
//                                 .doc(TeamManager().currentTeamId)
//                                 .collection('self_items')
//                                 .doc(docId)
//                                 .update({
//                                   'item_name': editedItemName,
//                                   'quantity': editedQuantity,
//                                   'edit_time': Timestamp.now(),
//                                   'is_edited': true,
//                                 });
//                             print('[DEBUG] Firestore update succeeded for docId: $docId');
//                             Navigator.pop(context);
//                             _fetchAllTeamData();
//                           } catch (e) {
//                             print('[ERROR] Error editing item: $e');
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Error editing item: $e')),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Please fill both fields')),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.blue[900],
//                       ),
//                       child: Text('Save Changes'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void _deleteItemFromFirestore(
//     BuildContext context,
//     String docId,
//     String itemName,
//     String quantity,
//     bool isDone,
//     String price,
//   ) async {
//     try {
//       final deletedItem = {
//         'add_time': Timestamp.now(),
//         'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
//         'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
//         'edit_time': null,
//         'is_done': isDone,
//         'is_edited': false,
//         'item_name': itemName,
//         'price': price,
//         'quantity': quantity,
//       };

//       print('[DEBUG] Deleting item: $itemName, docId: $docId');
//       await FirebaseFirestore.instance
//           .collection('teams')
//           .doc(TeamManager().currentTeamId)
//           .collection('self_items')
//           .doc(docId)
//           .delete();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Item "$itemName" deleted'),
//           action: SnackBarAction(
//             label: 'Undo',
//             onPressed: () async {
//               try {
//                 await FirebaseFirestore.instance
//                     .collection('teams')
//                     .doc(TeamManager().currentTeamId)
//                     .collection('self_items')
//                     .add(deletedItem);
//                 print('[DEBUG] Undo delete succeeded for item: $itemName');
//                 _fetchAllTeamData();
//               } catch (e) {
//                 print('[ERROR] Error undoing delete: $e');
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error undoing delete: $e')),
//                 );
//               }
//             },
//           ),
//           duration: Duration(seconds: 5),
//         ),
//       );
//       _fetchAllTeamData();
//     } catch (e) {
//       print('[ERROR] Error deleting item: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting item: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               GreetWidget(),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: _isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : _teamData.isEmpty
//                         ? Center(child: Text('No gatherings yet'))
//                         : ListView.builder(
//                             padding: EdgeInsets.all(16.0),
//                             itemCount: _teamData.length,
//                             itemBuilder: (context, index) {
//                               final teamId = _teamData.keys.elementAt(index);
//                               final team = _teamData[teamId]!;
//                               final teamName = team['name'] as String;
//                               final isSelf = team['isSelf'] as bool;
//                               final items = _teamItems[teamId] ?? [];
//                               final estimatedCost = _calculateEstimatedCost(teamId);
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
//                                     child: Container(
//                                       padding: EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.3),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: Offset(0, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             teamName,
//                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                           ),
//                                           Icon(
//                                             _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   AnimatedSize(
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.easeInOut,
//                                     child: _expandedTeamId == teamId
//                                         ? Container(
//                                             padding: EdgeInsets.all(16),
//                                             child: SingleChildScrollView(
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         'Grocery List',
//                                                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                                                       ),
//                                                       Text(
//                                                         'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
//                                                         style: TextStyle(fontSize: 14, color: Colors.black),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(height: 8),
//                                                   _buildAddItem(context),
//                                                   Column(
//                                                     children: items.map<Widget>((doc) {
//                                                       final data = doc.data() as Map<String, dynamic>;
//                                                       final docId = doc.id;
//                                                       final itemName = data['item_name'] ?? '';
//                                                       final quantity = data['quantity'] ?? '';
//                                                       final isDone = data['is_done'] ?? false;
//                                                       final price = data['price'] ?? 'Rs. 0';
//                                                       return _buildListItem(
//                                                         docId,
//                                                         itemName,
//                                                         quantity,
//                                                         isDone,
//                                                         price,
//                                                       );
//                                                     }).toList(),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox.shrink(),
//                                   ),
//                                   SizedBox(height: 16),
//                                 ],
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             setState(() {
//               _micActive = !_micActive;
//             });
//             if (_micActive) {
//               _micService.setListening(true);
//               _micService.showVoiceInputDialog(context, () {
//                 if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
//                   _addItemToFirestore(_micService.name!, _micService.quantity!);
//                 }
//               }, () {
//                 setState(() {
//                   _micActive = false;
//                 });
//               });
//             } else {
//               _micService.setListening(false);
//             }
//           } catch (e) {
//             print('[ERROR] MicService error: $e');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error with mic service: $e')),
//             );
//           }
//         },
//         backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
//         elevation: 6.0,
//         child: Icon(_micActive ? Icons.mic_off : Icons.mic),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

// // Debouncer class to limit setState calls
// class Debouncer {
//   final int milliseconds;
//   VoidCallback? _action;
//   Timer? _timer;

//   Debouncer({required this.milliseconds});

//   void run(VoidCallback action) {
//     _timer?.cancel();
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groz2/service/suggestion.dart';
import 'dart:async';
import '../service/mic.dart';
import '../widgets/greet.dart';
import '../service/handle_teams.dart';


class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MicService _micService = MicService();
  bool _micActive = false;
  Map<String, Map<String, dynamic>> _teamData = {};
  Map<String, List<QueryDocumentSnapshot>> _teamItems = {};
  String? _expandedTeamId;
  bool _isLoading = true;
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final Trie _trie = Trie();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Debouncer for onChanged
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _fetchAllTeamData();
  }

  Future<void> _fetchAllTeamData() async {
    final user = _currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      print('[DEBUG] Fetching teams for user: ${user.uid}');
      final currentTeamsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('current_teams')
          .get();

      final teamData = <String, Map<String, dynamic>>{};
      final teamItems = <String, List<QueryDocumentSnapshot>>{};

      for (final doc in currentTeamsSnapshot.docs) {
        final data = doc.data();
        teamData[doc.id] = {
          'teamId': doc.id,
          'name': data['name'] ?? 'Unnamed Team',
          'isSelf': false,
        };
      }

      final selfTeamSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('admin', isEqualTo: user.uid)
          .where('isSelf', isEqualTo: true)
          .get();

      if (selfTeamSnapshot.docs.isNotEmpty) {
        final selfTeam = selfTeamSnapshot.docs.first;
        final selfTeamId = selfTeam.id;
        if (!teamData.containsKey(selfTeamId)) {
          teamData[selfTeamId] = {
            'teamId': selfTeamId,
            'name': selfTeam['name'] ?? 'Self',
            'isSelf': true,
          };
        }
      }

      for (final teamId in teamData.keys) {
        final itemsSnapshot = await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .collection('self_items')
            .get();
        teamItems[teamId] = itemsSnapshot.docs;
      }

      setState(() {
        _teamData = teamData;
        _teamItems = teamItems;
        _isLoading = false;
      });
      print('[DEBUG] Fetched ${teamData.length} teams');
    } catch (e) {
      print('[ERROR] Error fetching team data: $e');
      setState(() => _isLoading = false);
    }
  }

  void _toggleTeamExpansion(String teamId, String teamName, bool isSelf) {
    setState(() {
      if (_expandedTeamId == teamId) {
        _expandedTeamId = null;
      } else {
        _expandedTeamId = teamId;
        TeamManager().setCurrentTeam(teamId, teamName, context);
      }
    });
  }

  double _calculateEstimatedCost(String teamId) {
    final items = _teamItems[teamId] ?? [];
    return items.fold(0.0, (sum, doc) {
      final data = doc.data() as Map<String, dynamic>;
      final priceStr = (data['price'] ?? 'Rs. 0').replaceAll('Rs. ', '');
      final price = double.tryParse(priceStr) ?? 0.0;
      return sum + price;
    });
  }

  Widget _buildAddItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddItemDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 16.0, right: 16.0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.blue[600]),
            SizedBox(width: 10),
            Text(
              'Add Item',
              style: TextStyle(fontSize: 16, color: Colors.blue[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    String docId,
    String itemName,
    String quantity,
    bool isDone,
    String price,
  ) {
    final textLength = (itemName + quantity).length;
    final containerHeight = textLength > 20 ? 80.0 : 60.0;
    final maxItemNameLength = 10;
    final truncatedItemName = itemName.length > maxItemNameLength
        ? '${itemName.substring(0, maxItemNameLength)}...'
        : itemName;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: containerHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDone ? Colors.green[200] : Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isDone,
            onChanged: (value) async {
              if (value == null) return;
              final currentUserId = _currentUser?.uid;
              if (currentUserId == null) return;

              try {
                final itemRef = FirebaseFirestore.instance
                    .collection('teams')
                    .doc(TeamManager().currentTeamId)
                    .collection('self_items')
                    .doc(docId);
                final itemSnap = await itemRef.get();
                final data = itemSnap.data() as Map<String, dynamic>;
                final lastCheckedBy = data['checked_by'] ?? '';

                if (value && !isDone) {
                  await itemRef.update({
                    'is_done': true,
                    'edit_time': Timestamp.now(),
                    'is_edited': true,
                    'checked_by': currentUserId,
                  });
                  _addToRecommendations(itemName, 'weekly', DateTime.now().toIso8601String().split('T')[0]);
                } else if (!value && isDone) {
                  if (lastCheckedBy == currentUserId) {
                    await itemRef.update({
                      'is_done': false,
                      'edit_time': Timestamp.now(),
                      'is_edited': true,
                      'checked_by': null,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Only the user who checked can uncheck this item.')),
                    );
                    return;
                  }
                }
                _fetchAllTeamData();
              } catch (e) {
                print('[ERROR] Error updating is_done: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating item: $e')),
                );
              }
            },
          ),
          Expanded(
            child: Text(
              '$truncatedItemName - $quantity',
              style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$price',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          if (!isDone)
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20),
                  onPressed: () {
                    _showEditItemDialog(context, docId, itemName, quantity, price);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20),
                  onPressed: () {
                    _deleteItemFromFirestore(context, docId, itemName, quantity, isDone, price);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _addToRecommendations(String itemName, String frequency, String lastPurchased) async {
    try {
      await _firestore.collection('recommend').add({
        'item_name': itemName,
        'frequency': frequency,
        'last_purchased': lastPurchased,
        'team_id': TeamManager().currentTeamId,
        'remind_date': _calculateRemindDate(lastPurchased, frequency),
      });
      print('[DEBUG] Recommendation added for team: ${TeamManager().currentTeamId}, item: $itemName');
    } catch (e) {
      print('[ERROR] Error adding recommendation: $e');
    }
  }

  String _calculateRemindDate(String lastPurchased, String frequency) {
    final lastPurchasedDate = DateTime.parse(lastPurchased);
    if (frequency == 'daily') {
      return lastPurchasedDate.add(Duration(days: 1)).toIso8601String().split('T')[0];
    } else if (frequency == 'weekly') {
      return lastPurchasedDate.add(Duration(days: 7)).toIso8601String().split('T')[0];
    } else if (frequency == 'monthly') {
      return lastPurchasedDate.add(Duration(days: 30)).toIso8601String().split('T')[0];
    }
    return lastPurchased;
  }

  void _addItemToFirestore(String itemName, String quantity) async {
    try {
      final user = _currentUser;
      final userName = user?.displayName ?? user?.email ?? 'Unknown';
      final teamId = TeamManager().currentTeamId;
      print('[DEBUG] Adding item to Firestore: $itemName, quantity: $quantity, teamId: $teamId');
      final docRef = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .collection('self_items')
          .add({
        'add_time': Timestamp.now(),
        'assigned_by': userName,
        'bought_by': userName,
        'edit_time': null,
        'is_done': false,
        'is_edited': false,
        'item_name': itemName,
        'price': 'Rs. 299',
        'quantity': quantity,
        'checked_by': null,
      });
      print('[DEBUG] Firestore write succeeded for teamId: $teamId, docId: ${docRef.id}');
      // Add recommendation when item is created
      await _addToRecommendations(itemName, 'weekly', DateTime.now().toIso8601String().split('T')[0]);
      _fetchAllTeamData();
    } catch (e) {
      print('[ERROR] Error adding item to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding item: $e')),
      );
    }
  }

  void _showAddItemDialog(BuildContext context) {
    String itemName = '';
    String quantity = '';
    List<String> suggestions = [];
    final itemNameController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[900]!, Colors.blue[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add New Item',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: itemNameController,
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.shopping_cart, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        itemName = value;
                        _debouncer.run(() {
                          setState(() {
                            suggestions = _trie.getSuggestions(value.toLowerCase());
                            print('[DEBUG] Filtering suggestions for query: $value');
                            print('[DEBUG] Suggestions: $suggestions');
                          });
                        });
                      },
                    ),
                    if (suggestions.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = suggestions[index];
                            return ListTile(
                              title: Text(
                                suggestion,
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                itemNameController.text = suggestion;
                                itemName = suggestion;
                                setState(() {
                                  suggestions = [];
                                  print('[DEBUG] Selected suggestion: $suggestion');
                                });
                              },
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 16),
                    TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.numbers, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        quantity = value;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (itemName.isNotEmpty && quantity.isNotEmpty) {
                          _addItemToFirestore(itemName, quantity);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill both fields')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[900],
                      ),
                      child: Text('Add Item'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showEditItemDialog(BuildContext context, String docId, String itemName, String quantity, String price) {
    String editedItemName = itemName;
    String editedQuantity = quantity;
    List<String> suggestions = [];
    final itemNameController = TextEditingController(text: itemName);
    final quantityController = TextEditingController(text: quantity);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[900]!, Colors.blue[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Item',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: itemNameController,
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.shopping_cart, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        editedItemName = value;
                        _debouncer.run(() {
                          setState(() {
                            suggestions = _trie.getSuggestions(value.toLowerCase());
                            print('[DEBUG] Filtering suggestions for query: $value');
                            print('[DEBUG] Suggestions: $suggestions');
                          });
                        });
                      },
                    ),
                    if (suggestions.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = suggestions[index];
                            return ListTile(
                              title: Text(
                                suggestion,
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                itemNameController.text = suggestion;
                                editedItemName = suggestion;
                                setState(() {
                                  suggestions = [];
                                  print('[DEBUG] Selected suggestion: $suggestion');
                                });
                              },
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 16),
                    TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.numbers, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        editedQuantity = value;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (editedItemName.isNotEmpty && editedQuantity.isNotEmpty) {
                          try {
                            print('[DEBUG] Updating item: $editedItemName, quantity: $editedQuantity, docId: $docId');
                            await FirebaseFirestore.instance
                                .collection('teams')
                                .doc(TeamManager().currentTeamId)
                                .collection('self_items')
                                .doc(docId)
                                .update({
                                  'item_name': editedItemName,
                                  'quantity': editedQuantity,
                                  'edit_time': Timestamp.now(),
                                  'is_edited': true,
                                });
                            print('[DEBUG] Firestore update succeeded for docId: $docId');
                            Navigator.pop(context);
                            _fetchAllTeamData();
                          } catch (e) {
                            print('[ERROR] Error editing item: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error editing item: $e')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill both fields')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[900],
                      ),
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _deleteItemFromFirestore(
    BuildContext context,
    String docId,
    String itemName,
    String quantity,
    bool isDone,
    String price,
  ) async {
    try {
      final deletedItem = {
        'add_time': Timestamp.now(),
        'assigned_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
        'bought_by': _currentUser?.displayName ?? _currentUser?.email ?? 'Unknown',
        'edit_time': null,
        'is_done': isDone,
        'is_edited': false,
        'item_name': itemName,
        'price': price,
        'quantity': quantity,
      };

      print('[DEBUG] Deleting item: $itemName, docId: $docId');
      await FirebaseFirestore.instance
          .collection('teams')
          .doc(TeamManager().currentTeamId)
          .collection('self_items')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item "$itemName" deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('teams')
                    .doc(TeamManager().currentTeamId)
                    .collection('self_items')
                    .add(deletedItem);
                print('[DEBUG] Undo delete succeeded for item: $itemName');
                _fetchAllTeamData();
              } catch (e) {
                print('[ERROR] Error undoing delete: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error undoing delete: $e')),
                );
              }
            },
          ),
          duration: Duration(seconds: 5),
        ),
      );
      _fetchAllTeamData();
    } catch (e) {
      print('[ERROR] Error deleting item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue[100]!, Colors.grey[300]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              GreetWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _teamData.isEmpty
                        ? Center(child: Text('No gatherings yet'))
                        : ListView.builder(
                            padding: EdgeInsets.all(16.0),
                            itemCount: _teamData.length,
                            itemBuilder: (context, index) {
                              final teamId = _teamData.keys.elementAt(index);
                              final team = _teamData[teamId]!;
                              final teamName = team['name'] as String;
                              final isSelf = team['isSelf'] as bool;
                              final items = _teamItems[teamId] ?? [];
                              final estimatedCost = _calculateEstimatedCost(teamId);
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _toggleTeamExpansion(teamId, teamName, isSelf),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            teamName,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            _expandedTeamId == teamId ? Icons.expand_less : Icons.expand_more,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: _expandedTeamId == teamId
                                        ? Container(
                                            padding: EdgeInsets.all(16),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Grocery List',
                                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                                      ),
                                                      Text(
                                                        'Est. Cost: Rs. ${estimatedCost.toStringAsFixed(2)}',
                                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8),
                                                  _buildAddItem(context),
                                                  Column(
                                                    children: items.map<Widget>((doc) {
                                                      final data = doc.data() as Map<String, dynamic>;
                                                      final docId = doc.id;
                                                      final itemName = data['item_name'] ?? '';
                                                      final quantity = data['quantity'] ?? '';
                                                      final isDone = data['is_done'] ?? false;
                                                      final price = data['price'] ?? 'Rs. 0';
                                                      return _buildListItem(
                                                        docId,
                                                        itemName,
                                                        quantity,
                                                        isDone,
                                                        price,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            setState(() {
              _micActive = !_micActive;
            });
            if (_micActive) {
              _micService.setListening(true);
              _micService.showVoiceInputDialog(context, () {
                if (_micService.intent == 'add' && _micService.name != null && _micService.quantity != null) {
                  _addItemToFirestore(_micService.name!, _micService.quantity!);
                }
              }, () {
                setState(() {
                  _micActive = false;
                });
              });
            } else {
              _micService.setListening(false);
            }
          } catch (e) {
            print('[ERROR] MicService error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error with mic service: $e')),
            );
          }
        },
        backgroundColor: _micActive ? Colors.grey[300] : Colors.blue[300],
        elevation: 6.0,
        child: Icon(_micActive ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Debouncer class to limit setState calls
class Debouncer {
  final int milliseconds;
  VoidCallback? _action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}