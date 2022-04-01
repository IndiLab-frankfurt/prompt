import 'package:prompt/shared/enums.dart';

enum CanMoveNext { filledOut, always, custom, videoCompleted }

enum CanMoveBack { always, never, custom }

enum PageType { questions, text, image, video, audio, custom }

const session_zero = {"title": "", "id": "sociodemographic", "pages": []};

const page_socio = {
  "id": "socio_1",
  "type": PageType.questions,
  "canMoveNext": CanMoveNext.filledOut,
  "questions": [question_age, question_gender]
};

const question_age = {
  "id": "age",
  "text": "Wie alt bist du?",
  "type": QuestionType.text_numeric,
};

const question_gender = {
  "id": "gender",
  "text": "Welchem Geschlecht fühlst du dich zugehörig?",
  "type": QuestionType.multiple,
  "choices": {"male": "Männlich", "female": "Weiblich", "diverse": "Divers"}
};

const page_intro_distributed_learning = {
  "id": "intro_distributed_learning",
  "type": PageType.text,
  "canMoveNext": CanMoveNext.always,
  "paragraphs": [
    """Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen.
    Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteil ertklärt werden."""
  ]
};

const page_video_distributed_learning = {
  "id": "video_distributed_learning",
  "type": PageType.video,
  "canMoveNext": CanMoveNext.videoCompleted,
  "video": 'assets/videos/videoDistributedLearning.mp4'
};

const page_intro_planning = {
  "id": "intro_planning",
  "type": PageType.text,
  "canMoveNext": CanMoveNext.always,
  "paragraphs": [
    """Es kann schwierig sein, jeden Tag daran zu denken, Vokabeln zu lernen.
    Auf der nächsten Seite zeigt dir unser Monster einen Trick, der dir dabei hilft, dieses Ziel zu erreichen."""
  ]
};

const page_video_planning = {
  "id": "plan_creation",
  "type": PageType.custom,
  "canMoveNext": CanMoveNext.custom,
};
