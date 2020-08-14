String intro = "В заданиях Вам дадут слова, которые надо будет разделить на группы. Разделить нужно как можно быстрее, делая как можно меньше ошибок. Если Вы будете действовать слишком медленно или делать слишком много ошибок, результаты будет невозможно интерпретировать. Эта часть исследования займет около 5 минут.\n\n Вот список категорий и предметов, относящихся к ним:"; //<>//
String intro2 = "Помните:\n\n Держите пальцы на клавишах E и I, чтобы реагировать быстро\n\n Две надписи сверху указывают на слова, соответствующие каждой клавише\n\n Каждое слово соответствует какой-то категории, обычно ее легко определить\n\n Этот тест не дает результатов, если проходить его медленно - отвечайте как можно быстрее\n\n Из-за скорости будет несколько ошибок — это нормально\n\n Старайтесь не отвлекаться\n\n Чтобы продолжить нажмите ENTER";
String cat1 = "Академический обман", cat2 = "Честность", cat3 = "Хорошо", cat4 = "Плохо";
String[] cats = {cat1, cat2, cat3, cat4};
String[] stimCheat = {"приписывание баллов", "списывание", "плагиат", "покупка работ", "шпаргалка", "ложь", "обман", "фабрикация", "пиратство", "читинг"};
String[] stimHonest = {"ссылки", "честные баллы", "своя работа", "цитирование", "правила", "совесть", "достоверность",  "справедливость", "объективность", "порядочность"};
String[] stimGood = {"радостный", "похвальный", "надежный", "смешной", "счастливый", "веселый", "добрый", "восхищенный", "гордый", "приятный"};
String[] stimBad = {"ненавистный", "досадный", "плохой", "ужасный", "кошмарный", "злoй", "жуткий", "вредный", "обидный", "опасный"};
int state, dstate, substate;
Librarian log;
String id = "0";
long lTimeCross = 0;
long lTimeStim = 0;

PImage img;

String defaultName = "Забыли Ввести Имя";

String task;
String stimBuf;
String catLeft;
String catRight;
boolean failed = false;

ArrayList<String> sesList;
ArrayList<Integer> ansList;
ArrayList<Integer> indList;

final int[] SESLENGTH = {20, 20, 40, 40, 20, 40, 40};
final int SESAMOUNT = 7;
final int STIMSINCAT = 10;

final int SHOWCROSS = 1;
final int SHOWSTIM = 2;
final int SHOWTASK = 3;

int nSession = 0;
int nList = 0;
int corAnswer = 0;
int curAnswer = 0;

Window window;



void setup() {
  fullScreen();
  img = loadImage("stims.jpg");
  //size(500, 500);
  state = 0;
  dstate = 0;
  substate = 0;
  window = new Window();
  while (!window.isFilled()) {
    System.out.println("Wait for it...");
  }
  String participant[] = window.getValues();
  id = String.valueOf(day()) + "_" + String.valueOf(month()) + "_" + String.valueOf(year())+ "_" + String.valueOf(hour())+ "_" + String.valueOf(minute()) + "_" + String.valueOf(second()) + "_" + participant[5];
  log = new Librarian(id);
  log.table0(participant);
  generate();
}

void draw() {
  switch(dstate) {
  case SHOWTASK:
    background(0, 0, 0);
    fill(255);
    textSize(width/50);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    text(task, width/2, height/2 + width/10, width - width/10, height - height/10);
    textSize(width/45);
    rectMode(CORNER);
    textAlign(CENTER);
    text(catLeft, 0, height/50, width/5, height/3);
    text(catRight, width - width/5, height/50, width/5, height/3);
    break;

  case SHOWCROSS:
    failed = false;
    if (millis() < lTimeCross) {
      background(0, 0, 0);
      textSize(width/15);
      rectMode(CENTER);
      textAlign(CENTER, CENTER);
      text("+", width/2, height/2);
      textSize(width/45);
      rectMode(CORNER);
      textAlign(CENTER);
      text(catLeft, 0, height/50, width/5, height/3);
      text(catRight, width - width/5, height/50, width/5, height/3);
    } else {
      lTimeStim = millis() + 1000;
      dstate = SHOWSTIM;
      String buf = id + "," + "SHOWSTIM" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
      log.write(buf);
    }
    //System.out.println("SHOWCROSS");
    break;

  case SHOWSTIM:
    background(0, 0, 0);
    textSize(width/25);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    text(stimBuf, width/2, height/2);

    if (failed) {
      fill(255, 0, 0);
      textSize(width/15);
      rectMode(CENTER);
      text("X", width/2, height/2 + height/10);
      fill(255);
    }

    textSize(width/45);
    rectMode(CORNER);
    textAlign(CENTER);
    text(catLeft, 0, height/50, width/5, height/3);
    text(catRight, width - width/5, height/50, width/5, height/3);
    //System.out.println("SHOWSTIM");
    break;
  }
}

void generate() {
  background(0, 0, 0);
  if (state == 0) {
    fill(255);
    textSize(width/60);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (substate == 0) {
      firstScreen();
    } else if (substate == 1) {
      text(intro2, width/2, height/2, width - width/10, height - height/10);
    }
  } else if (state == 1) {
    nSession = 0;
    nList = 0;
    catLeft = "Академический обман";
    catRight = "Честность";
    task = "Поместите Ваши средние или указательные пальцы на клавиши E и I. Слова, относящиеся к категориям, будут появляться друг за другом в середине экрана. Когда слово принадлежит категории слева, нажмите клавишу E, когда слово принадлежит категории справа, нажмите клавишу I. Объекты принадлежат только одной категории. Если Вы сделаете ошибку, появится X . Исправьте ошибку, нажав верную клавишу. \n\nКаждое слово предъявляется на 0.7 сек. ВЫПОЛНЯЙТЕ ТАК БЫСТРО, КАК ТОЛЬКО МОЖЕТЕ, ДЕЛАЯ КАК МОЖНО МЕНЬШЕ ОШИБОК.\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(1);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(2);
      indList.add(10+i);
    }
    //System.out.println("State 1 generated");
    dstate = SHOWTASK;
  } else if (state == 2) {
    nSession = 0;
    nList = 0;

    catLeft = "Хорошо";
    catRight = "Плохо";
    task = "Просмотрите- категории вверху изменились. Слова для сортировки изменились. Правила остаются теми же.\n\nКогда слово принадлежит категории слева, нажмите клавишу E, когда слово принадлежит категории справа, нажмите клавишу I. Слова принадлежат только одной категории. Если Вы сделаете ошибку, появится X . Исправьте ошибку, нажав верную клавишу. ДЕЙСТВУЙТЕ ТАК БЫСТРО, КАК ТОЛЬКО МОЖЕТЕ».\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimGood[i]);
      ansList.add(1);
      indList.add(20 + i);
      sesList.add(stimBad[i]);
      ansList.add(2);
      indList.add(30+i);
    }

    dstate = SHOWTASK;
  } else if (state == 3) {
    nSession = 0;
    nList = 0;

    catLeft = "Академический обман\nи\nХорошо";
    catRight = "Честность\nи\nПлохо";
    task = "Сверху Вы можете увидеть, что четыре ранее отдельные категории теперь объединены.\n\nПомните, каждое слово принадлежит только к 1 группе. Например, если категории «честность» и «хорошо» появляются в разных сторонах наверху, то слова, означающие «честность», должны быть отнесены в категорию «честность», а не в категорию «хорошо».\n\nИспользуйте клавиши E и I чтобы распределить слова по четырем категориям слева и справа. Исправляйте ошибки при помощи нажатия на другую клавишу.\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(1);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(2);
      indList.add(10+i);
      sesList.add(stimGood[i]);
      ansList.add(1);
      indList.add(20 + i);
      sesList.add(stimBad[i]);
      ansList.add(2);
      indList.add(30+i);
    }

    dstate = SHOWTASK;
  } else if (state == 4) {
    nSession = 0;
    nList = 0;

    catLeft = "Академический обман\nи\nХорошо";
    catRight = "Честность\nи\nПлохо";
    task = "Выполните сортировку по тем же четырем категориям снова. Следует выполнять задание как можно быстрее. Несколько ошибок допустимы.\n\nИспользуйте клавиши E и I чтобы распределить слова по четырем категориям слева и справа. Исправляйте ошибки при помощи нажатия на другую клавишу.\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(1);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(2);
      indList.add(10+i);
      sesList.add(stimGood[i]);
      ansList.add(1);
      indList.add(20 + i);
      sesList.add(stimBad[i]);
      ansList.add(2);
      indList.add(30+i);
    }

    dstate = SHOWTASK;
  } else if (state == 5) {
    nSession = 0;
    nList = 0;

    catLeft = "Честность";
    catRight = "Академический обман";
    task = "Заметьте: выше есть только 2 категории, их положение изменилось. Категория, которые была справа, теперь располагается слева, и наоборот. Попрактикуйтесь в новом расположении.\n\nИспользуйте клавиши E и I, чтобы распределять слова по категориям слева и справа. Исправляйте ошибки при помощи нажатия на другую клавишу\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(2);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(1);
      indList.add(10+i);
    }

    dstate = SHOWTASK;
  } else if (state == 6) {
    nSession = 0;
    nList = 0;

    catLeft = "Честность\nи\nХорошо";
    catRight = "Академический обман\nи\nПлохо";
    task = "Обратите внимание! Сверху сейчас возникли 4 категории в новой конфигурации. Помните, каждое слово принадлежит только к 1 группе.\n\nИспользуйте клавиши E и I чтобы распределить слова по четырем категориям слева и справа. Исправляйте ошибки при помощи нажатия на другую клавишу.\n\nЧтобы начать нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(2);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(1);
      indList.add(10+i);
      sesList.add(stimGood[i]);
      ansList.add(1);
      indList.add(20 + i);
      sesList.add(stimBad[i]);
      ansList.add(2);
      indList.add(30+i);
    }

    dstate = SHOWTASK;
  } else if (state == 7) {
    nSession = 0;
    nList = 0;

    catLeft = "Честность\nи\nХорошо";
    catRight = "Академический обман\nи\nПлохо";
    task = "Выполните сортировку по тем же четырем категориям снова. Следует выполнять задание как можно быстрее. Несколько ошибок допустимы.\n\nИспользуйте клавиши E и I чтобы распределить слова по четырем категориям слева и справа. Исправляйте ошибки при помощи нажатия на другую клавишу.\n\nЧтобы продолжить нажмите ПРОБЕЛ";
    sesList = new ArrayList<String>();
    ansList = new ArrayList<Integer>();
    indList = new ArrayList<Integer>();
    for (int i = 0; i < STIMSINCAT; i++) {
      sesList.add(stimCheat[i]);
      ansList.add(2);
      indList.add(i);
      sesList.add(stimHonest[i]);
      ansList.add(1);
      indList.add(10+i);
      sesList.add(stimGood[i]);
      ansList.add(1);
      indList.add(20 + i);
      sesList.add(stimBad[i]);
      ansList.add(2);
      indList.add(30+i);
    }

    dstate = SHOWTASK;
  } else if (state == 8) {
    task = "Это было просто космос! Спасибо за участие!\n\nЧтобы закончить, нажмите ENTER";
    dstate = SHOWTASK;
  }
}

void keyPressed() {
  if (key == ENTER) {
    if (state == 0) {
      if (substate == 0) {
        substate = 1;
        generate();
      } else if (substate == 1) {
        String buf = id + "," + "START" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
        log.write(buf);
        state = 1;
        generate();
      }
    } else if (state == 8) {
      exit();
    }
  }

  String buf;
  //System.out.println("Pressed in state 1");
  if (dstate == SHOWSTIM) {
    if (key == 'e' || key == 'E' || key == 'у' || key == 'У') {
      if (millis() < lTimeStim) {
        buf = id + "," + "ANS1" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
        curAnswer = 1;
        //System.out.println("Not too late");
      } else {
        buf = id + "," + "LANS1" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
        curAnswer = 1;
        //System.out.println("TOO LATE");
      }
      log.write(buf);
      if (curAnswer == corAnswer) {
        show();
      } else {
        failed = true;
      }
    } else if (key == 'i' || key == 'I' || key == 'ш' || key == 'Ш') {
      if (millis() < lTimeStim) {
        buf = id + "," + "ANS2" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
        curAnswer = 2;
      } else {
        buf = id + "," + "LANS2" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
        curAnswer = 2;
      }
      log.write(buf);
      if (curAnswer == corAnswer) {
        show();
      } else {
        failed = true;
      }
    }
  }

  if (dstate == SHOWTASK) {
    if (key == ' ') {
      buf = id + "," + "SSTART" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
      log.write(buf);
      //System.out.println("Spacebar for SHOWTASK pressed");
      show();
    }
  }
}

void show() {

  //System.out.println("show started");
  if (nSession < SESLENGTH[state - 1]) {
    //System.out.println("show if started");
    int i = int(random(sesList.size()));
    stimBuf = sesList.get(i);
    sesList.remove(i);
    corAnswer = ansList.get(i);
    ansList.remove(i);
    nList = indList.get(i);
    indList.remove(i);
    nSession++;
    lTimeCross = millis() + 1000;
    String buf = id + "," + "SHOWCROSS" + "," + millis() + "," + state + "," + nSession + "," + nList + "," + corAnswer;
    log.write(buf);
    dstate = SHOWCROSS;
    //System.out.println("show says dstate is " + dstate);
  } else {
    //System.out.println("show ifelse started");
    state++;
    generate();
  }
}

void firstScreen(){
  text(intro, width/2, height/3, width - width/10, height - height/10);
  imageMode(CENTER);
  image(img, width/2, height - height/3, width/2.5, width/5);
  text("Чтобы продолжить нажмите ENTER", width/2, height - height/7, width - width/10, height - height/10);
}
