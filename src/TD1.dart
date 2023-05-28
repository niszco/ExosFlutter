import 'dart:ffi';
import "dart:io";
import 'dart:math';

void main() {
  jeuDevinerNombre();
  print(sequenceComplementaireInversee("GTACA")); // TGTAC
  print(sequenceComplementaireInversee("CGATCGA")); // TCGATCG
  print(sequenceComplementaireInversee("ATCG")); // CGAT
}

// EXO 1 TD1 : OK !

void jeuDevinerNombre() {
  final aDeviner = 1 + Random().nextInt(100);
  final questionUser = "Choisi un nombre entre 1 et 100";
  int nbrEssais = 0;
  print(questionUser);
  for (int i = 0; i < 7; i++, nbrEssais++) {
    String? reponseUser = stdin.readLineSync();
    int reponseUserInt = int.parse(reponseUser!);
    if (reponseUserInt == aDeviner) {
      print("Après"
          " "
          "$nbrEssais"
          " "
          "essais, tu as trouvé le nombre mystère !");
      print("Le nombre mystère : " + aDeviner.toString());
      break;
    } else if (reponseUserInt > aDeviner) {
      print(
          "Le nombre que tu as choisi est plus grand que le nombre mystère !");
    } else if (reponseUserInt < aDeviner) {
      print(
          "Le nombre que tu as choisi est plus petit que le nombre mystère !");
    }
  }
  if (nbrEssais == 7) {
    print("Après"
        " "
        "$nbrEssais"
        " "
        "essais, tu n'as pas réussi à trouver le nombre mystère, GAME OVER !");
  }
}

// EXO2 TD1 : OK !

bool estADN(String seqADN) {
  for (int i = 0; i < seqADN.length; i++) {
    if (seqADN[i] != "A" &&
        seqADN[i] != "C" &&
        seqADN[i] != "G" &&
        seqADN[i] != "T") {
      print("Votre séquence ADN n'est pas conforme !");
      return false;
    } else if (seqADN == "") {
      return true;
    }
  }
  print("La séquence ADN est correcte !");
  return true;
}

// EXO3 TD1 : OK !

bool transcrit(seqADN) {
  String seqARN = "";
  for (int i = 0; i < seqADN.length; i++) {
    if (seqADN[i] == "T") {
      seqARN = seqADN.replaceAll(seqADN[i], "U");
    }
  }
  print(seqARN);
  return true;
}

// EXO4 TD1 : OK !

String baseComplementaire(String seqADN) {
  String baseComp = "";
  for (int i = 0; i < seqADN.length; i++) {
    if (seqADN[i] != "A" &&
        seqADN[i] != "C" &&
        seqADN[i] != "G" &&
        seqADN[i] != "T") {
      return baseComp;
    }
    switch (seqADN) {
      case "A":
        return "T";
      case "T":
        return "A";
      case "G":
        return "C";
      case "C":
        return "G";
    }
  }
  return baseComp;
}

// EXO5 TD1 :

String sequenceComplementaireInversee(String seqADN) {
  String complementaire = "";
  for (int i = seqADN.length - 1; i >= 0; i--) {
    complementaire += baseComplementaire(seqADN[i]);
  }
  return complementaire;
}

// EXO6 TD1 :

int nombreOccurrencesCodon(String codon, String seqADN) {
  int result = 0;
  for (int i = 0; i < seqADN.length - 2; i++) {
    String triplet = seqADN.substring(i, i + 3);
    if (triplet == codon) {
      result += 1;
    }
  }
  print(result);
  return result;
}
