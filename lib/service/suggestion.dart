class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
}

class Trie {
  TrieNode root = TrieNode();
  static const List<String> groceryItems = [
     "Apple", "Banana", "Carrot", "Tomato", "Potato", "Onion", "Garlic", "Cucumber", "Lettuce", "Spinach", 
  "Broccoli", "Cauliflower", "Peas", "Bell Pepper", "Zucchini", "Eggplant", "Cabbage", "Radish", "Squash", "Pumpkin", 
  "Mushroom", "Asparagus", "Brussels Sprouts", "Green Beans", "Sweet Potato", "Corn", "Olives", "Avocado", "Berries", 
  "Blueberries", "Strawberries", "Raspberries", "Blackberries", "Grapes", "Pineapple", "Mango", "Peach", "Plum", "Pear", 
  "Orange", "Lemon", "Lime", "Grapefruit", "Kiwi", "Pomegranate", "Papaya", "Watermelon", "Melon", "Cantaloupe", 
  "Cherries", "Coconut", "Apricot", "Fig", "Date", "Figs", "Tangerine", "Mandarin", "Clementine", "Lemonade", "Apple Juice", 
  "Tomato Sauce", "Coconut Milk", "Pineapple Juice", "Orange Juice", "Fruit Salad", "Carrot Juice", "Cucumber Juice", 
  "Ginger", "Chili", "Cilantro", "Parsley", "Basil", "Thyme", "Rosemary", "Oregano", "Sage", "Bay Leaves", "Chives", 
  "Dill", "Mint", "Curry Powder", "Paprika", "Turmeric", "Chili Powder", "Garlic Powder", "Onion Powder", "Cumin", 
  "Coriander", "Mustard", "Salt", "Black Pepper", "Peppercorn", "Soy Sauce", "Olive Oil", "Canola Oil", "Vegetable Oil", 
  "Coconut Oil", "Sesame Oil", "Avocado Oil", "Peanut Oil", "Vinegar", "Balsamic Vinegar", "White Vinegar", "Rice Vinegar", 
  "Apple Cider Vinegar", "Honey", "Maple Syrup", "Brown Sugar", "White Sugar", "Stevia", "Agave Syrup", "Molasses", 
  "Corn Syrup", "Baking Powder", "Baking Soda", "Cornstarch", "Flour", "All-Purpose Flour", "Whole Wheat Flour", 
  "Self-Raising Flour", "Almond Flour", "Rice Flour", "Coconut Flour", "Gluten-Free Flour", "Oats", "Rolled Oats", 
  "Instant Oats", "Steel-Cut Oats", "Rice", "White Rice", "Brown Rice", "Jasmine Rice", "Basmati Rice", "Sushi Rice", 
  "Wild Rice", "Quinoa", "Couscous", "Barley", "Millet", "Pasta", "Spaghetti", "Penne", "Fusilli", "Macaroni", "Lasagna", 
  "Ravioli", "Tortellini", "Noodles", "Ramen", "Rice Noodles", "Udon", "Egg Noodles", "Penne Rigate", "Farfalle", 
  "Orzo", "Fettuccine", "Tortilla", "Bagels", "Bread", "Whole Wheat Bread", "Sourdough", "Multigrain Bread", "Rye Bread", 
  "Pita Bread", "Ciabatta", "Baguette", "Croissant", "English Muffins", "Taco Shells", "Wraps", "Hot Dog Buns", 
  "Hamburger Buns", "Rolls", "Crackers", "Rice Cakes", "Granola", "Cereal", "Cornflakes", "Muesli", "Cheerios", 
  "Frosted Flakes", "Oatmeal", "Chia Seeds", "Flax Seeds", "Sunflower Seeds", "Pumpkin Seeds", "Sesame Seeds", "Peanuts", 
  "Almonds", "Cashews", "Walnuts", "Pistachios", "Pecans", "Hazelnuts", "Brazil Nuts", "Macadamia Nuts", "Chickpeas", 
  "Lentils", "Black Beans", "Kidney Beans", "Pinto Beans", "Garbanzo Beans", "Navy Beans", "Red Beans", "White Beans", 
  "Soy Beans", "Tofu", "Tempeh", "Edamame", "Hummus", "Tahini", "Peanut Butter", "Almond Butter", "Cashew Butter", 
  "Sunflower Butter", "Olives", "Pickles", "Sauerkraut", "Kimchi", "Mayonnaise", "Mustard", "Ketchup", "Barbecue Sauce", 
  "Hot Sauce", "Salsa", "Relish", "Chutney", "Tzatziki", "Soy Sauce", "Worcestershire Sauce", "Tabasco Sauce", 
  "Fish Sauce", "Steak Sauce", "Lemon Juice", "Lime Juice", "Orange Juice", "Vegan Cheese", "Cheddar Cheese", "Mozzarella", 
  "Parmesan", "Feta Cheese", "Ricotta", "Cottage Cheese", "Cream Cheese", "Brie", "Goat Cheese", "Gouda", "Swiss Cheese", 
  "Blue Cheese", "Provolone", "Pepper Jack Cheese", "Monterey Jack Cheese", "American Cheese", "Camembert", "Creamer", 
  "Yogurt", "Greek Yogurt", "Skyr", "Coconut Yogurt", "Almond Milk", "Soy Milk", "Oat Milk", "Rice Milk", "Coconut Milk", 
  "Whole Milk", "2% Milk", "1% Milk", "Skim Milk", "Buttermilk", "Heavy Cream", "Half and Half", "Sour Cream", "Eggs", 
  "Butter", "Margarine", "Ghee", "Shortening", "Cream Cheese", "Ice Cream", "Frozen Yogurt", "Gelato", "Sorbet", 
  "Frozen Vegetables", "Frozen Fruits", "Frozen Pizza", "Frozen Dinner", "Frozen Fries", "Frozen Waffles", "Frozen Fish", 
  "Frozen Meat", "Frozen Chicken", "Frozen Shrimp", "Frozen Burritos", "Frozen Smoothie Packs", "Frozen Breakfast Foods", 
  "Canned Beans", "Canned Vegetables", "Canned Tomatoes", "Canned Fruit", "Canned Tuna", "Canned Salmon", "Canned Chicken", 
  "Canned Soup", "Canned Chili", "Canned Mushrooms", "Canned Corn", "Canned Peas", "Canned Coconut Milk", "Canned Corned Beef", 
  "Canned Sardines", "Canned Pineapple", "Canned Peaches", "Canned Baked Beans", "Canned Spaghetti", "Canned Pasta", 
  "Canned Chicken Broth", "Canned Beef Broth", "Canned Vegetable Broth", "Canned Pumpkin", "Canned Carrots", "Canned Olives", 
  "Frozen Vegetables", "Frozen Pizza", "Frozen Meals", "Frozen Meatballs", "Frozen Fish Sticks", "Frozen Fries", 
  "Frozen Breakfast Foods", "Frozen Tater Tots", "Frozen Hash Browns", "Frozen Bagels", "Frozen Dumplings", "Frozen Chicken Wings", 
  "Frozen Waffles", "Frozen Pancakes", "Frozen Fruit", "Frozen Vegetables", "Frozen Bread", "Frozen Pizza Dough", "Frozen Garlic Bread", 
  "Frozen Pastry", "Frozen Pretzels", "Frozen Pies", "Frozen Burritos", "Frozen Smoothies", "Frozen Smoothie Packs"
,
  "Notebook", "Pen", "Pencil", "Eraser", "Sharpener", "Highlighter", "Marker", "Sticky Notes", "Post-it Notes", 
  "Whiteboard", "Whiteboard Marker", "Clipboard", "Stapler", "Staple Remover", "Paper Clips", "Binder Clips", 
  "Scissors", "Glue Stick", "PVA Glue", "Tape", "Double-Sided Tape", "Masking Tape", "Scotch Tape", "Cello Tape", 
  "Craft Paper", "Construction Paper", "Cardstock", "Tracing Paper", "Graph Paper", "Colored Paper", "A4 Paper", 
  "Legal Pads", "Index Cards", "Flash Cards", "Envelope", "Business Cards", "Card Holders", "File Folders", 
  "Hanging Folders", "Portfolio", "Binder", "Ring Binder", "Lever Arch File", "File Box", "Filing Cabinet", "File Divider", 
  "Document Wallet", "Document Sleeve", "Document Folder", "Binder Pockets", "Paper Fasteners", "Punching Machine", 
  "Hole Punch", "Binder Rings", "Index Dividers", "Tab Dividers", "Binder Spine Labels", "Paper Cutter", "Paper Trimmer", 
  "Laminator", "Laminating Pouches", "Ruler", "Tape Measure", "Compass", "Protractor", "Triangle Ruler", "Set Square", 
  "Letter Opener", "Bookends", "Bookmarks", "Label Maker", "Address Labels", "Name Tags", "Rubber Stamps", "Stamp Pads", 
  "Ink Pads", "Ink Refills", "Stamp Ink", "Stickers", "Washi Tape", "Glitter Glue", "Craft Scissors", "Cutting Mat", 
  "Craft Knife", "Rotary Cutter", "Scrapbook", "Scrapbook Paper", "Photo Corners", "Corner Rounder", "Memory Album", 
  "Stamping Blocks", "Punches", "Die Cuts", "Brads", "Eyelets", "Lace Ribbon", "Satin Ribbon", "Burlap Ribbon", 
  "Cotton Thread", "Embroidery Thread", "Beads", "Button Pins", "Safety Pins", "Paperclips", "Clothespins", "Tack Pins", 
  "Binder Clips", "Rubber Bands", "Elastic Bands", "Safety Pins", "Thimble", "Seam Ripper", "Iron-on Transfers", 
  "Fabric Paint", "Embroidery Floss", "Beading Needles", "Sewing Needles", "Embroidery Hoop", "Felt", "Fabric Scissors", 
  "Yarn", "Knitting Needles", "Crochet Hook", "Mosaic Tiles", "Craft Glue", "Craft Paper Roll", "Paint Brushes", 
  "Canvas", "Acrylic Paint", "Watercolors", "Oil Paint", "Pastels", "Colored Pencils", "Crayons", "Markers", "Charcoal", 
  "Drawing Paper", "Sketching Paper", "Canvas Board", "Oil Pastels", "Watercolor Paper", "Paint Palette", "Acrylic Brushes", 
  "Coloring Pencils", "Chalk", "Colored Chalk", "Chalkboard", "Chalk Eraser", "Glitter", "Glitter Glue", "Beads", 
  "Feathers", "Gemstones", "Sequins", "Confetti", "Pipe Cleaners", "Pom-Poms", "Foam Sheets", "Craft Foam", "Canvas Bags", 
  "Cotton Bags", "Tie-Dye Kit", "Stencils", "Markers", "Pastel Colors", "Crayon Sets", "Dry Erase Markers", "Easel", 
  "Drawing Board", "Canvas Stretcher Bars", "Paint Set", "Watercolor Brushes", "Fine Liner Pens", "Art Sketchbook", 
  "Art Paper", "Art Pencils", "Graphite Pencils", "Watercolor Pencils", "Artist Easel", "Palette Knives", "Stamping Tool", 
  "Stamping Ink", "Paper Punch", "Scoring Tool", "Creasing Tool", "Embossing Tool", "Rubber Bands", "Paper Clips", 
  "Clipboards", "Shredder", "Shredding Bags", "Staples", "Staple Gun", "Clipboard Holder", "Index Cards", "File Label Stickers", 
  "Paper Labels", "Permanent Markers", "Chalk Markers", "Paint Pens", "Ink Pens", "Fountain Pens", "Ballpoint Pens", 
  "Gel Pens", "Rollerball Pens", "Fineliner Pens", "Highlighters", "Colored Ink Pens", "Calligraphy Pens", "Brush Pens", 
  "Mechanical Pencils", "Pencil Leads", "Pencil Refills", "Colored Pencils", "Watercolor Markers", "Wax Crayons", 
  "Modeling Clay", "Air-Dry Clay", "Plasticine", "Play Dough", "Clay Tools", "Glue Gun", "Fabric Markers", "Fabric Paint", 
  "Felt Tips", "Poster Board", "Bulletin Board", "Graph Paper Notebook", "Sketchbook", "Watercolor Set", "Erasable Markers", 
  "Permanent Markers", "Stencil Sheets", "Graphing Calculator", "Protractor Set", "Ruler Set", "Compass Set", 
  "Student Desk Organizer", "Pen Holder", "File Organizer", "Drawer Organizer", "Magazine Holders", "Storage Bins", 
  "Rolling Cart", "Craft Cart", "Storage Box", "Wall Organizer", "Cork Board", "Whiteboard Eraser", "Classroom Posters", 
  "Desk Clock", "Desktop Organizer", "Desk Tray", "Folder Labels", "Index Divider Labels", "Notebook Stickers", "Color Labels", 
  "Ruler Stickers", "Envelope Stickers", "Pen Refills", "Stationery Kit", "Professional Stationery", "Luxury Pens", 
  "Stationery Paper", "Personalized Stationery", "Greeting Cards", "Thank You Cards", "Invitation Cards", "Anniversary Cards", 
  "Birthday Cards", "Wedding Invitations", "Stationery Sets", "Calligraphy Ink", "Calligraphy Pens", "Greeting Card Holder", 
  "Gift Wrap", "Gift Bags", "Gift Tags", "Gift Ribbon", "Gift Tissue Paper", "Wrapping Paper", "Holiday Cards", 
  "Christmas Cards", "Halloween Cards", "Valentine’s Day Cards", "Mother’s Day Cards", "Father’s Day Cards", "Greeting Card Box", 
  "Postage Stamps", "Envelopes with Seal", "Postage Labels", "Personalized Stamps", "Custom Stationery", "Stationery Box", 
  "Note Pads", "Memo Pads", "Desk Pads", "Sticky Notes", "Memo Stickers", "Calligraphy Brushes", "Fountain Ink", 
  "Inkwell", "Travel Desk Organizer", "Clip-on Reading Light", "Desk Lamp", "Art Desk", "Craft Table", "Project Board", 
  "Craft Paper Roll", "Bullet Journal", "Planner", "Diary", "To-Do List", "Organizer", "Task List", "Calendar", "Wall Calendar", 
  "Desk Calendar", "Printable Planners", "Personal Planner", "Daily Planner", "Weekly Planner", "Monthly Planner", "Agenda", 
  "Productivity Planner", "Life Planner", "Goal Planner", "Bullet Journal Stickers", "Planner Stickers", "Notebook Stickers", 
  "File Divider Stickers", "Reminder Stickers", "Scheduling Stickers", "Business Planner", "Habit Tracker", "Vision Board", 
  "Calendar Stickers", "Family Calendar", "Kids Planner", "School Planner", "Student Planner", "Work Planner", "Printable Calendar"
,
  "Turmeric", "Cumin", "Coriander", "Fennel", "Fenugreek", "Cardamom", "Clove", "Cinnamon", "Mustard Seeds", 
  "Asafoetida (Hing)", "Chili Powder", "Garam Masala", "Tamarind", "Amchur (Dry Mango Powder)", "Kasuri Methi (Dried Fenugreek Leaves)", 
  "Black Pepper", "Bay Leaves", "Ajwain (Carom Seeds)", "Poppy Seeds", "Nigella Seeds (Kalonji)", "Saffron", "Jaggery", 
  "Curry Leaves", "Ginger Powder", "Garlic Powder", "Curry Powder", "Chaat Masala", "Tandoori Masala", "Panch Phoran", 
  "Kala Namak (Black Salt)", "Rock Salt", "Salt", "Methi Seeds", "Kalonji (Nigella Seeds)", "Turmeric Root", "Curry Paste", 
  "Chili Flakes", "Rosemary", "Thyme", "Mint", "Lemon Grass", "Mango Powder", "Cinnamon Sticks", "Star Anise", "Sichuan Pepper", 
  "Aniseed", "Caraway Seeds", "Zaatar", "Tamarind Paste", "Szechuan Pepper", "Rasam Powder", "Tikka Masala", "Meethi Dana", 
  "Chili Garlic Paste", "Methi Leaves", "Lemon Zest", "Sweet Lime", "Cinnamon Powder", "Clove Powder", "Dried Red Chilies", 
  "Black Salt", "Sesame Seeds", "Coconut Powder", "Fried Onion", "Mace", "Javitri", "Pineapple Powder", "Rose Petals", 
  "Bamboo Salt", "Shahi Jeera", "Kesar", "Kesar Powder", "Khoya", "Dry Ginger", "Long Pepper", "Coconut Oil", "Ghee", 
  "Mustard Oil", "Vegetable Oil", "Peanut Oil", "Sesame Oil", "Mustard Powder", "Mango Pickle", "Garlic Chutney", 
  "Chili Chutney", "Coconut Chutney", "Mint Chutney", "Tamarind Chutney", "Tomato Chutney", "Onion Chutney", "Chili Powder Mix", 
  "Chana Masala", "Sambar Powder", "Methi Thepla", "Namak Pare", "Dosa Masala", "Biryani Masala", "Pulao Masala", 
  "Khade Masale", "Pav Bhaji Masala", "Lassi Masala", "Vermicelli Masala", "Chatpati Masala", "Baking Powder", "Chili Sauce", 
  "Coriander Seed Powder", "Jaggery Powder", "Dry Mango Powder", "Masala Tea Powder", "Tandoori Spice Mix", "Chutney Powder", 
  "Sundal Powder", "Bhel Puri Masala", "Pudina Powder", "Chili Masala", "Sambhar Powder", "Idli Powder", "Sundal Masala", 
  "Tamarind Concentrate", "Ginger Garlic Paste", "Almond Powder", "Rice Flour", "Rice Bran Oil", "Soya Sauce", "Tamarind Concentrate", 
  "Curry Leaf Powder", "Hing Powder", "Tamarind Concentrate", "Pista Powder", "Cashew Powder", "Pineapple Masala", 
  "Jowar Flour", "Ragi Flour", "Milling Masala", "Wheat Flour", "Kuttu Flour", "Sattu", "Millet Flour", "Barley Flour", 
  "Fenugreek Leaves", "Curry Masala", "Pudina Masala", "Carom Seeds", "Cheese Powder", "Moong Dal Masala", "Fried Gram Flour", 
  "Garlic Chutney Powder", "Roasted Methi Powder", "Dried Ginger Powder", "Whole Wheat Flour", "Rice Bran Powder", 
  "Cucumber Powder", "Rose Petal Powder", "Curry Blossom Powder", "Sesame Powder", "Cumin Powder", "Coriander Powder", 
  "Cabbage Powder", "Amla Powder", "Dried Mango Powder", "Chili Lime Powder", "Tomato Powder", "Curry Powder Mix", "Cucumber Chutney", 
  "Jeera Powder", "Pulses Masala", "Cumin Seed Powder", "Turmeric Seed", "Curry Flower", "Curry Powder", "Garlic Masala", 
  "Cumin Seed", "Cardamom Powder", "Chili Pepper", "Curry Spice", "Pineapple Spice", "Soya Sauce Powder", "Dry Curry Powder", 
  "Ajwain Powder", "Cardamom Seeds", "Pumpkin Seeds", "Sunflower Seeds", "Watermelon Seeds", "Coriander Seed", "Oregano", 
  "Curry Paste", "Garlic Chutney Mix", "Dried Lemongrass", "Rosemary Powder", "Paprika", "Coconut Grated", "Coconut Powder", 
  "Sesame Chutney", "Mint Paste", "Ginger Chutney", "Cinnamon Oil", "Coconut Milk", "Masala Pepper", "Gravy Masala", 
  "Saag Masala", "Ginger Paste", "Tomato Paste", "Ajwain Seeds", "Kalpasi", "Chili Paste", "Tamarind Salt", "Fennel Seed Powder", 
  "Flax Seeds", "Cucumber Masala", "Cardamom Pods", "Ginger Masala", "Fennel Seed Masala", "Coconut Water", "Sambar Masala", 
  "Pumpkin Spice", "Dried Fennel", "Clove Oil", "Black Peppercorns", "Curry Leaf", "Methi Seed", "Khadi Masala", "Chana Masala", 
  "Peanut Masala", "Basil Seeds", "Jaggery", "Vinegar", "Molasses", "Rice Bran", "Peach Powder", "Apricot Powder", 
  "Rose Syrup", "Saffron Essence", "Cardamom Essence", "Poppy Seed Oil", "Corn Starch", "Rasam Masala", "Garlic Masala Powder", 
  "Chili Ginger Sauce", "Biryani Masala Powder", "Pineapple Ginger Masala", "Dry Chutney Mix", "Sandalwood Powder", 
  "Cumin Powder", "Rasam Powder", "Fresh Turmeric", "Hing Extract", "Saffron Powder", "Curry Leaf Extract", "Fennel Extract", 
  "Chili Oil", "Olive Oil", "Curry Masala Mix"

  ];

  Trie() {
    // Initialize Trie with grocery items
    for (var item in groceryItems) {
      insert(item.toLowerCase());
    }
  }

  // Insert a word into the Trie
  void insert(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      if (!node.children.containsKey(letter)) {
        node.children[letter] = TrieNode();
      }
      node = node.children[letter]!;
    }
    node.isEndOfWord = true;
  }

  // Get suggestions based on a prefix
  List<String> getSuggestions(String prefix) {
    TrieNode node = root;
    for (int i = 0; i < prefix.length; i++) {
      String letter = prefix[i];
      if (!node.children.containsKey(letter)) return [];
      node = node.children[letter]!;
    }
    return _getWords(node, prefix);
  }

  // Helper method to get all words from a node
  List<String> _getWords(TrieNode node, String prefix) {
    List<String> words = [];
    if (node.isEndOfWord) words.add(prefix);
    for (var letter in node.children.keys) {
      _getWords(node.children[letter]!, prefix + letter).forEach(words.add);
    }
    return words;
  }
}