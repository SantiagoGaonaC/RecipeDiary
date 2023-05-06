class rec {
  String sImagen;
  String sTitulo;
  String sSumary;
  String sIntru;
  String ingredientes;
  String sPasos;
  int sId;

  static String getIngredi(Map<String, dynamic> json) {
    String Ingre = "";
    for (var reciperf in json["extendedIngredients"]) {
      Ingre += reciperf["original"] + "|";
    }
    print(Ingre);
    Ingre = Ingre.replaceAll("|", "\n");
    return Ingre;
  }

  static String getInstru(Map<String, dynamic> json) {
    String pasos = "";
    print("8888888888888888888888");
    for (var reciperf in json["analyzedInstructions"]) {
      for (var paso in reciperf["steps"]) {
        pasos += "${"${paso["number"]}: " + paso["step"]}|";
      }
    }
    print(pasos);
    pasos = pasos.replaceAll("|", "\n");
    return pasos;
  }

  factory rec.fromJson(Map<String, dynamic> json) {
    return rec(
      sImagen: json['image'] as String,
      sTitulo: json['title'] as String,
      sIntru: json['instructions'] as String,
      sSumary: json['summary'] as String,
      sId: json['id'] as int,
      ingredientes: getIngredi(json),
      sPasos: getInstru(json),
    );
  }

  rec(
      {required this.sImagen,
      required this.sTitulo,
      required this.sIntru,
      required this.sSumary,
      required this.sId,
      required this.ingredientes,
      required this.sPasos});

  static List<rec> fromJsonList(List<dynamic> jsonList) {
    List<rec> listaRecipes = [];
    if (jsonList != null) {
      for (var reciperf in jsonList) {
        final recipeFinal = rec.fromJson(reciperf);
        listaRecipes.add(recipeFinal);
      }
    }
    return listaRecipes;
  }
}
