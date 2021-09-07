// Variables used by Scriptable.
// These must be at the very top of the file. Do not edit.
// always-run-in-app: true; icon-color: blue;
// icon-glyph: magic;

async function createWidget() {
  // Create new empty ListWidget instance
  let listwidget = new ListWidget();
  let stack = listwidget.addStack();
  // stack.centerAlignContent();
  // stack.topAlignContent();
  stack.setPadding(0,3,3,1);

  

  //顯示靜態文字

  // const gradient = new LinearGradient();
  // gradient.locations = [0, 1];
  // gradient.colors = [new Color("#F5DB1A"), new Color("#F3B626")];
  // listwidget.backgroundGradient = gradient;

  const gradient = new LinearGradient()
  gradient.locations = [0, 1]
  gradient.colors = [
    new Color("141414"),
    new Color("13233F")
  ]
  listwidget.backgroundGradient = gradient




  // let topText = stack.addText("GingerCat");
  // topText.textColor = new Color("#000000");
  // topText.font = Font.boldSystemFont(20);
  // // topText.centerAlignText();

  // let logo_img = await new Request("https://i.imgur.com/IWONFex.png").loadImage()
  // let topLogo = stack.addImage(logo_img);
  // topLogo.imageSize = new Size(30, 30);

  // listwidget.addSpacer(2);
  
  // let SecondText = listwidget.addText("Test");
  // SecondText.textColor = new Color("#ffffff");
  // SecondText.font = new Font('SF Mono', 10);

  // listwidget.addSpacer(2);

  let qStock_a = await quote_crypto_data('0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c');
  let qStock_b = await quote_crypto_data('0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82');
  // let qStock_3 = await quote_crypto_data('0x82C19905B036bf4E329740989DCF6aE441AE26c1');
  // let qStock_4 = await quote_crypto_data('0xba2ae424d960c26247dd6c32edc70b295c744c43');
  // let qStock_5 = await quote_crypto_data('0x7083609fce4d1d8dc0c979aab8c869ea2c873402');

  // let stkdata = await queryStockData();
  // let price = stkdata.quoteSummary.result[0].price;
  // let real_price = price.regularMarketPrice.raw.toFixed(2);

  // let qStock_price = qStock.raw;
  // let changeValue = listwidget.addText('BTC:' + qStock);
  // changeValue.textColor = Color.white();
  // changeValue.font = Font.boldMonospacedSystemFont(20);


  //------------------------------------------------------------------------------------------








  //------------------------------------------------------------------------------------------
  let row1 = listwidget.addStack();
  // Add Stock Symbol
  let stockSymbol_1 = row1.addText('BTC');
  stockSymbol_1.textColor = Color.white();
  stockSymbol_1.font = Font.boldMonospacedSystemFont(12);
  //Add Current Price
  row1.addSpacer();
  let symbolPrice_1 = row1.addText(qStock_a);
  symbolPrice_1.textColor = Color.white();
  symbolPrice_1.font = Font.boldMonospacedSystemFont(12);


  let row2 = listwidget.addStack();
  // Add Stock Symbol
  let stockSymbol_2 = row2.addText('CAKE');
  stockSymbol_2.textColor = Color.white();
  stockSymbol_2.font = Font.boldMonospacedSystemFont(12);
  //Add Current Price
  row2.addSpacer();
  let symbolPrice_2 = row2.addText(qStock_b);
  symbolPrice_2.textColor = Color.white();
  symbolPrice_2.font = Font.boldMonospacedSystemFont(12);











  //------------------------------------------------------------------------------------------








  //------------------------------------------------------------------------------------------


  let new_Date = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '');

  // refersh
  // let nextRefresh = Date.now() + 1000*5 // add 5 second to now
  let nextRefresh = Date.now() + 1000*60;
  listwidget.refreshAfterDate = new Date(nextRefresh);

  let row0 = listwidget.addStack();
  // Add Stock Symbol
  let stockSymbol_0 = row0.addText(new_Date);
  stockSymbol_0.textColor = Color.white();
  stockSymbol_0.font = Font.boldMonospacedSystemFont(12);


  // Return the created widget
  return listwidget;
}

let widget = await createWidget();

// Check where the script is running
if (config.runsInWidget) {
  // Runs inside a widget so add it to the homescreen widget
  Script.setWidget(widget);
} else {
  // Show the medium widget inside the app
  widget.presentMedium();
}
Script.complete();




async function quote_crypto_data(crypto_address) {
  var url = "https://egg.gingercat.io/" + encodeURIComponent(crypto_address);
  let req = new Request(url)
  return await req.loadString()
}
