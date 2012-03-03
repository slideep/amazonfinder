{

$Id: uFinderResources.pas,v 1.9 2004/05/10 06:15:17 slide Exp $

Description:

Resource strings for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.

}

unit uFinderResources;

interface

uses

  uFinderGlobals;

resourcestring

  {---------------------------------------------------------------------------}
  { Currency information }

  SCurrencyAddrRemote =
    'http://www.bof.fi/ohi/fin/0_new/0.1_valuuttak/fix-rec.txt';
  SCurrencyAddrLocal = DataDir + '\fix-rec.txt';

  {---------------------------------------------------------------------------}
  { Application information }

  SAppTitle = 'Amazon Product Finder';
  SAmazonFinderWeb = 'http://amazonfinder.sourceforge.net/';
  SSubmitBugUrl =
    'https://sourceforge.net/tracker/?group_id=102751&atid=632734';

  {---------------------------------------------------------------------------}
  { Developer information }

  SDefaultAssociateID = 'webservices-20';
  SDeveloperToken = 'DXZ05JAAKIREU';
  SDeveloperWishlist =
    'http://www.amazon.com/exec/obidos/registry/2IXPCFJYON5IW';

  {---------------------------------------------------------------------------}
  { Search types }

  SSearchTypeHeavy = 'Heavy';
  SSearchTypeLite = 'Lite';

  {---------------------------------------------------------------------------}
  { AWS searches }

  SActorSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&ActorSearch=%s&mode=dvd&sort=&offer=All&type=heavy&page=%d&f=xml';
  SAuthorSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&AuthorSearch=%s&mode=books&type=%s&page=%d&f=xml';
  SArtistSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&ArtistSearch=%s&mode=music&type=%s&page=%d&f=xml';
  SBlendedSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&BlendedSearch=%s&type=%s&page=%d&f=xml';
  SDirectorSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&DirectorSearch=%s&mode=dvd&type=%s&page=%d&f=xml';
  SKeywordSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&KeywordSearch=%s&mode=%s&sort=+pmrank&offer=All&type=heavy&page=%d&f=xml';
  SPowerSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&PowerSearch=%s&mode=%s&type=%s&page=%d&f=xml';
  SPowerSearchSimple =
    'http://xml.amazon.com/onca/xml3?PowerSearch=%s&mode=books&t=webservices-20&dev-t=DXZ05JAAKIREU&type=lite&f=xml';
  SAsinSearch =
    'http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=DXZ05JAAKIREU&AsinSearch=%s&type=%s&f=xml';

  {---------------------------------------------------------------------------}
  { Search modifiers }

  SAddVariations         = '&variations=yes';
  SLocaleSearch          = 'locale=%s';
  SUsedOffering          = '&offer=Used&offerpage=%d';
  SThirdPartyNewOffering = '&offer=ThirdPartyNew&offerpage=%d';
  SCollectibleOffering   = '&offer=Collectible&offerpage=%d';
  SRefurbishedOffering   = '&offer=Refurbished&offerpage=%d';
  SAllOffering           = '&offer=All&offerpage=%d';

  {---------------------------------------------------------------------------}
  { Sort Results }

  SSortFeaturedItems = '+pmrank';
  SSortBestselling = '+salesrank';
  SSortAvgCustomerReview = '+reviewrank';
  SSortPriceLowHigh = '+pricerank';
  SSortPriceHighLow = '+inverse-pricerank';
  SSortPublicationDate = '+daterank';
  SSortAlphabeticalAZ = '+titlerank';
  SSortAlphabeticalZA = '+-titlerank';

  {---------------------------------------------------------------------------}
  { Power searches }

  SPowerSearchAsing = 'asin:';
  SPowerSearchAuthor = 'author:';
  SPowerSearchAuthorExact = 'author-exact:';
  SPowerSearchAuthorBegins = 'author-begins:';
  SPowerSearchIsbn = 'isbn:';
  SPowerSearchKeywords = 'keywords:';
  SPowerSearchKeywordsBegin = 'keywords-begin:';
  SPowerSearchLanguage = 'language:';
  SPowerSearchPubdate = 'pubdate:';
  SPowerSearchPubdateBefore = 'pubdate:before:';
  SPowerSearchPubdateDuring = 'pubdate:during:';
  SPowerSearchPubdateAfter = 'pubdate:after:';
  SPowerSearchPublisher = 'publisher:';
  SPowerSearchSubject = 'subject:';
  SPowerSearchSubjectWords = 'subject-words-begin:';
  SPowerSearchSubjectBegins = 'subject-begins:';
  SPowerSearchTitle = 'title:';
  SPowerSearchTitleWords = 'title-words-begin:';
  SPowerSearchTitleBegins = 'title-begins:';

  {---------------------------------------------------------------------------}
  { Amazon gateways }

  SGWLocaleUS = 'http://xml.amazon.com/onca/xml3';
  SGWLocaleUK = 'http://xml-eu.amazon.com/onca/xml3';
  SGWLocaleDE = 'http://xml-eu.amazon.com/onca/xml3';
  SGWLocaleJP = 'http://xml.amazon.com/onca/xml3';

  {---------------------------------------------------------------------------}
  { Amazon WS shopping cart URL }

  SAddItemURL = 'http://xml.amazon.com/onca/xml3?ShoppingCart=add&f=xml&dev-t='
    + '%s&t=' + '%s&Asin.%s=' + '%d';
  SAddItemAction      = 'http://www.amazon.com/exec/obidos/dt/assoc/handle-buy-box=%s';
  SAddItemASINValue   = 'asin.%s';
  SAddItemTagValue    = 'tag-value';
  SAddItemDevTagValue = 'dev-tag-value';
  SAddItemSubmit      = 'submit.add-to-cart';
    
  {---------------------------------------------------------------------------}
  { File filters and descriptions }

  SSearchResultFilterExt = '*.xml';
  SSearchResultFilterDesc = 'Amazon Product Finder Search Result Files';
  SCurrencyFilterExt = '*.txt';
  SCurrencyFilterDesc = 'Amazon Product Finder Currency Files';

  {---------------------------------------------------------------------------}
  { Error messages, warnings and info messages }

  SShoppingCartAdd = 'Added item to shopping cart.';
  SNoImageAssociated = 'No product image available.';
  SCurrencyInfoNotAvailable = 'Currency information couldn''t be loaded.';
  SSearchInProgress = 'Search in progress';  
  SSearchFinished = 'Search Finished.';
  SSearchLoaded = 'Loaded search successfully.';
  SLocalSearchLoaded = 'Amazon Product Finder - Loaded Local Search';
  SSearchParseFailed = 'Search results couldn''t be parsed.';
  SLoadedSearchParseFailed = 'Loaded search results couldn''t be parsed.';
  SSearchResultNone = 'There are no exact matches for the search.';
  SSearchResultMany = 'Search provided many results.';
  SSearchNotSaved = 'Search is not saved. Save it now?';
  SSearchResultShow = 'Showing ' + '%d' + ' out of ' + '%d' + ' results';
  SAddSearchToFav = 'Add search to favorites?';
  SRemoveSearchFromFav = 'Remove search from favorites?';
  SEnterSearchParams = 'Please select search parameters.';
  SSelectHeavySearchType = 'Please switch to heavy search type.';
  SSelectLiteSearchType = 'Please switch to lite search type.';
  SProgramReady = 'Amazon Product Finder - [Ready]';
  SProgramExit = 'Are you sure you want to exit?';
  SStatusModified = 'Modified';
  SStatusDebug = 'Debug';
  SStatusReady = 'Ready';
  SPriceNotifier = 'Price is accurate as of the date/time ' +
    'indicated.  Prices and product availability ' +
    'are subject to change.  Any price displayed ' +
    'on the Amazon website at the time of purchase ' +
    'will govern the sale of this product.';

  SAmazonPriceDate = 'Amazon.com Price: %s (as of %s)'; // TODO: add price, date time, and Details-link
  SAmazonPriceTime = 'Amazon.com Price: %s (as of %s)'; // TODO: add price, time, and More info-link


  {---------------------------------------------------------------------------}
  { Shell messages }

  SSearchUsingAPF = 'For Products from Amazon.com using APF...';

  {---------------------------------------------------------------------------}
  { Locales }

  SLocaleUS = 'us';
  SLocaleUK = 'uk';
  SLocaleDE = 'de';
  SLocaleJP = 'jp';

  {---------------------------------------------------------------------------}
  { MainForm resourcestrings }
  // TODO: rename these globally to more sensitive names!
  SImageGif = 'image/gif';
  SAmazonProductFinder = '';
  SLoadedSearch = '';
  SOpenAmazonSearchResults = 'Open Amazon Product Finder Search';
  SAmazonProductFinderSearchFilesXm = 'Amazon Product Finder Files (*.xml)|*.xml';
  SSaveAmazonSearchResults = '';
  SAmazonFinderSearchFilesXmlXml = '';
  SHTMLFileHtmlHtml = 'HTML Files (*.html)|*.html';
  SAnExtensionMustBeSpesifiedToIndi = 'An extension must be specified!';
  STheAmazonProductFinderFormat = '';
  SExportSearchResults = '';
  STextFilesTabCsvTabCsv = '';
  SCacheSearch = '';
  SPage = 'page';
  SPage1 = '';
  SXml = '';
  SSearchXml = 'search.xml';
  SSearchFor = 'Search for ';
  SProduced = 'produced';
  SFile = '';
  SExists = '';
  SOverwrite = '';
  SLog = '';
  SRetrieving = 'parsing';
  SKilobytes = 'bytes';
  SXml1 = '';
  SAddSearchFolder = 'Add New Search Folder';
  SSimilarProductsCaption = 'Similar Products %d';

  {---------------------------------------------------------------------------}
  { AWS response tags }

  SErrorMsg = 'ErrorMsg';
  SDetails = 'Details';
  SUrl = 'Url';
  SImageUrlMedium = 'ImageUrlMedium';
  SImageUrlLarge = 'ImageUrlLarge';
  SAuthors = 'Authors';
  SAuthor = 'Author';
  SArtists = 'Artists';
  SArtist = 'Artist';
  SBrowseNode = 'BrowseNode';
  SBrowseList = 'BrowseList';
  SBrowseName = 'BrowseName';
  SDirectors = 'Directors';
  SDirector = 'Director';
  SMedia = 'Media';
  SProductName = 'ProductName';
  STracks = 'Tracks';
  STrack = 'Track';
  SCatalog = 'Catalog';
  SOurPrice = 'OurPrice';
  SAvailability = 'Availability';
  SSalesRank = 'SalesRank';
  SReviews = 'Reviews';
  SCustomerReview = 'CustomerReview';
  SRating = 'Rating';
  SSummary = 'Summary';
  SComment = 'Comment';
  SManufacturer = 'Manufacturer';
  SReleaseDate = 'ReleaseDate';
  STheaterReleaseDate = 'TheatricalReleaseDate';
  SListPrice = 'ListPrice';
  SUsedPrice = 'UsedPrice';
  SAsin = 'Asin';
  SThirdPartyNewPrice = 'ThirdPartyNewPrice';
  SAvgCustomerRating = 'AvgCustomerRating';
  SSimilarProducts = 'SimilarProducts';

  {---------------------------------------------------------------------------}
  { Search types }

  SBooks      = 'Books';
  SDVD        = 'DVD';
  SMagazines  = 'Magazines';
  SMusic      = 'Music';
  SVideogames = 'Videogames';

  {---------------------------------------------------------------------------}
  { Image types }

  SImageSmall  = 'small';
  SImageMedium = 'medium';
  SImageHeavy  = 'heavy';

  {---------------------------------------------------------------------------}
  { Alarm name types }

  SAlarmPrice   = 'PriceChange';
  SAlarmSales   = 'SalesRank';
  SAlarmAverage = 'AvgRating';

implementation

end.
