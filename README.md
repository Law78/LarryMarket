# Ruby on Rails Lacerba - 1° Parte

Dalla cartella del Desktop, lancio il comando di generazione di una applicazione Rails:

```
rails new LorenzoMarket
```

questa mi crea una cartella sul Desktop che sarà LorenzoMarket o un qualsiasi altro nome che scriverò.

Questo comando mi genera una struttura con una serie di files. I più importanti sono:

1. **Gemfile**: file dove inserisco le gem da installare per i 3 ambienti: development, test e production;
2. La cartella **app**, che conterrà le cartelle: controllers, models e views. Inoltre la cartella helpers. Sempre in app troverò la cartella views/layouts che conterrà il file **application.html.erb** che sarà la nostra scatola dei nostri template views che creeremo.
3. La cartella **config** dove troverò il file **routes.rb** che definisce l'instradamento della mia applicazione, la cartella **config/environments** dove trovo le configurazioni specifiche per i tre ambienti ed il file **database.yml** per le impostazioni del database;
4. La cartella **db** conterrà i file di migrazione che verranno generati e lo schema associato al database che andrò a costruire;;
5. La cartella **public** con le pagine statiche, tipicamente le pagine di errore e la favicon.ico;
6. La cartella **test** dove andrò ad inserire i TDD.

In automatico partirà il comando:

```
bundle install
```
che ha l'effetto di installare le gemme di default della versione Rails in uso. Per la 5.0.0 ho 63 gemme di cui 15 dipendenze.

Lanciamo il server integrato di Rails (PUMA):

```
cd LorenzoMarket
rails server
```

In futuro si usa l'abbreviazione:

```
rails s
```

Apro il browser su **localhost:3000** e mi appare la schermata di **Yay! You're on Rails!**

Dal terminale posso leggere:

1. La versione di Rails
2. La versione di Ruby
3. L'indirizzo di ascolto (con porta)
4. L'ambiente avviato (development di default)

Quando avvio il browser posso notare:

```
Started GET "/" for 127.0.0.1 at ...
Processing by Rails::WelcomeController#index as HTML
...
Rendering /home/lorenzo..../welcome/index.html.erb ... within layouts/application.html.erb
```

Ovvero ho ricevuto una richiesta GET, Rails processa il Controller **WelcomeController** con relativa action **index** che a sua volta farà la visualizzazione (render) del file **index.html.erb**, un file html con del codice Ruby (**E**mbedded **R**u**b**y). Il tutto inglobato nel file application.html.erb :)

## Rails

Rails è un framework, ovvero una collezione di librerie che ci permettono di scrivere una applicazione web in maniera _rapida_!

## Git

Andiamo a creare il repo sul sito web github e poi dalla cartella di progetto andiamo a scrivere:

```
git init
git commit -m 'first commit'
git status
git add .
git status
git commit -m 'first commit'
git remote add origin https://github.com/Law78/LarryMarket.git
git remote -v
git push -u origin master
```

## Generazione di una pagina

Creo la prima pagina con il comando:

```
rails generate controller pages home
```

che nella versione semplificata sarà:

```
rails g controller pages home
```

Questo comando genera:

1. L'instradamento (route) per il verbo GET per il controller pages e la view (azione) home;
2. Crea il controller pages_controller.rb in app/controllers;
3. Crea la view home.html.erb in app/views/pages
4. Crea l'helper del controller in app/helpers chiamato pages_helper.rb;
5. Crea il test unit per il controller in test/controllers chiamato pages_controller_test.rb;
6. Crea un file coffee e un foglio di stile scss.

Ora la nostra pagina creata è raggiungible dal browser:
http://localhost:3000/pages/home

Se andassi su un altro indirizzo avrà un messaggio di errore di "Routing Error". 

Per modificare questa prima view, mi basta modificare il file home.html.erb in app/views/pages.

## Impostiamo la pagina principale del sito

Il file responsabile del routing è il file **routes.rb** che trovo sotto la cartella config.
Qui trovo l'unica impostazione creata dal comando precedente che ha creato il controller pages e l'azione home.
Questa istruzione indica che al verbo HTTP GET avvio l'azione home del controller pages.

Per indicare la home page devo modificare questa istruzione con:

```
root 'pages#home'
```

Ovviamente posso avere una sola root.
A questo punto posso inviare le modifiche su git:

```
git add -A
git commit -m 'Add Pages Controller'
git push
```


## Installazione di Evoluspencil

Al posto di Balsamiq per fare prototype di un sito web, posso installare evoluspencil.

## Generazione della pagina About

Partendo dal comando inviato precedentemente:

```
rails g controller pages home
```

Possiamo aggiungere la nostra seconda pagina di About andando ad aggiungere manualmente.
Nel controller PageController ho la definizione della pagina home, per cui mi basta aggiungere la definizione dell'azione about:

```ruby
def home
end

def about
end
```

In views/pages adesso creo il file about.html.erb

In routes.rb inserisco il route per il verbo HTML GET:

```ruby
get 'pages\about'
```

**Attenzione:** Con questo route la mia pagina sarà raggiungibile solo specificando il path controller/azione: 'http://localhost:3000/pages/about'
Se invece volessi raggiungere la pagina da: 'http://localhost:3000/about', mi conviene scrivere l'instradamento in questo modo:

```ruby
get 'about' => 'pages#about'
```

Ovviamente se scrivessi:

```ruby
get 'pippo/about' => 'pages#about'
```

è come se "nascondessi" il reale controller con la parola 'pippo'.

**Nota Bene:** La regola root tienila in alto!

Posso vedere i vari instradamenti con il seguente comando:

```
rake routes
```

e notare i due URI PATTERN dell'instradamento in base alla regole viste precedentemente:

```
/pages/about
/about
```

Potrei aggiungere il secondo test in test/controllers all'interno del file pages_controller_test.rb:

```ruby
test "should get about" do
	get pages_about_url
	assert_response :success
end
```

Questo è un semplice test chiamato "should..." che si aspetta una risposta (la assert) di successo, nel caso di una get all'indirizzo di pages_about_url.

## L'embed Ruby

I file html che rappresentano la view, hanno estensione erb, questo perchè posso scrivere del codice Ruby all'interno dell'HTML. Altra cosa importante da sapere è che tutto ciò che creo all'interno del mio controller è facilmente accessibile alla view associata.
Quindi l'embed Ruby ci permette di utilizzare codice Ruby all'interno della view in 2 modi:

```ruby
<%= __codice__ %>
<% __codice__ %>
```

La prima istruzione è utilizzata per produrre un risultato, dal codice scritto, visualizzato sulla pagina HTML. La seconda istruzione è utilizzata per eseguire del codice ma senza visualizzarlo nella pagina HTML:

```ruby
<p>Torna alla <%= link_to 'Home','/' %></p>
```

Potevo fare di meglio, scrivere il comando:

```
rake routes
```

e andare a prendere il PREFIX. Posso usarlo, aggiungengo **_path** all'interno del link_to:

```ruby
<p>Torna alla <%= link_to 'Home', root_path %></p>
...
<p>Torna alla <%= link_to 'About', about_path %></p>
```

# Menu

La creazione del menù non è fattibile con la ripetizione del codice di navigazione, anche grazie alla funzione link_to. Il concetto è il DRY (Don't Repeat Yourself).

Dobbiamo sfruttare la pagina base che ingloba le nostre view: **application.html.erb**

Qui troviamo la funzione Ruby **yeld** che serve proprio per inglobare il codice template delle view che creiamo successivamente.

Quindi la navigazione dobbiamo inserirla in questa pagina.

Possiamo sfruttare dei framework per costruire la parte grafica del frontend. Possiamo scegliere tra Bootstrap, Materialize o Foundation.

Utilizziamo [Materialize](http://materializecss.com/getting-started.html) (di Google). Dal sito possiamo vedere che è possibile installarlo ed usarlo, tramite l'opzione Third-party Options.
Vediamo che esiste una gem 'materialize-sass' e che la documentazione ci chiede di assicurarci della presenza della gem 'sass-rails' (di default è presente!).

Pertanto nel file GEMFILE vado ad inserire:

```ruby
gem 'materialize-sass'
```

Dal terminale, dalla root del progetto, lancio il comando:

```
bundle install
```

Dalla documentazione della gem, nella parte **Usage**, vedo che dovrò fare ulteriori settaggi. Uno è quello di importare, nel file application.css sotto app/assets/stylesheet il seguente codice:

```sass
@import "materialize";
```
**ATTENZIONE**: Il file ha estensione .css, rinominarlo in .scss

Ora nella sezione b.Javascript, vado ad inserire le due righe di codice presenti, nel file app/assets/javascript/application.js . **ATTENZIONE**: Il codice in grigio in questo caso è vero e proprio codice! Non cancellarlo!

```js
//= require jquery
//= require materialize-sprockets
```

Adesso siamo pronti con Materialize :)

## La barra di navigazione

Sul sito Materialize, scelgo Components->Navbar e copio il codice relativo alla Navbar ottimizzata per il mobile. In application.html.erb vado ad inserire la seguente riga di codice, prima dello **yield**:

```ruby
<%= render 'layouts/navigation' %>
```

e creo un file in app/views/layouts che chiamerò '_navigation.html.erb' e conterrà il codice preso da Materialize. I template parziali devono iniziare con l'underscore!

In realtà non è finita. Nel file application.html.erb, prima della fine del body, vado ad inserire:

```html
<script>
  $(".button-collapse").sideNav();
</script>
```

Altrimenti non funziona il menù per il mobile! Manca ancora l'icona del menù. Per aggiungerla devo inserire il codice delle Icons che troverò sempre sul sito Materialize e che inserirò prima della chiusura del tag head e lo pulisco (e modifico) come segue:

```html
<nav class="amber darken-3>
  <div class="container nav-wrapper">
    <%= link_to "Lorenzo Market", root_path, class: "brand-logo" %>
    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
    <ul class="right hide-on-med-and-down">
      <%= link_to "About" , about_path %>
    </ul>
    <ul class="side-nav" id="mobile-demo">
      <%= link_to "About" , about_path %>
    </ul>
  </div>
</nav>
```

Ho modificato il link relativo al logo, in cui utilizzo la funzione rails link_to e come terzo parametro specifico la classe CSS.
Inoltre ho inserito il colore "amber darken-3" come classe CSS di tutta la barra di navigazione

Per creare una barra di navigazione fissa in alto posso far uso della classe css navbar-fixed ed usare il tag HTML5 header:

```
<header class="navbar-fixed">
  <%= render "layouts/navigation" %>
</header>
```
```

Aggiungiamo un container alla nostra barra di navigazione, in modo da avere le scritte leggermente distanziate, e lo faccio inserendo la classe container sul div subito dopo la nav.

## Footer

Andiamo a creare il footer della nostra pagina. Anche qui creo un parziale che carico con la funzione render e che chiamerò con:

```
<%= render 'layouts/footer' %>
```

Il file sarà '_footer.html.erb'. La vogliamo rendere fissa, per cui devo aggiungere il CSS relativo allo Sticky Footer così come da guida nel relativo file application.scss. Devo inserire lo yield tra due tag main.
