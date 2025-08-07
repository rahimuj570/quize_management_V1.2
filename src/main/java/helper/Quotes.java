package helper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class Quotes {

	public static enum QuoteCategory {
		SEE_QUESTION, CREATE_QUESTION, SEE_QUESTION_SET, CREATE_EXAM;
	}

	public static ArrayList<String> getShowQuestion() {
		ArrayList<String> seeQuestionQuotes = new ArrayList<>(
				Arrays.asList("A good question is the beginning of deep understanding.",
						"Behind every question lies a spark of curiosity.",
						"Teachers reveal the depth of learning through the questions they review.",
						"Every question is a window into a student’s thinking.",
						"To see a question is to glimpse the learner’s journey.",
						"Questions are not interruptions—they are invitations to teach.",
						"The quality of questions reflects the quality of thought.",
						"Reviewing questions is where teaching meets reflection.",
						"Each question is a chance to guide, inspire, and clarify.",
						"Great teachers listen not just to answers, but to the questions asked."));
		return seeQuestionQuotes;
	}

	public static ArrayList<String> getShowQuestionSet() {
		ArrayList<String> seeQuestionSetQuotes = new ArrayList<>(
				Arrays.asList("A question set is a blueprint for learning.",
						"Each set of questions tells a story of intention and insight.",
						"Assessment is not just evaluation—it’s guidance.",
						"Question sets reflect the teacher’s vision for growth.",
						"Grouped questions build bridges to deeper understanding.",
						"A well-structured set leads to well-structured thinking.",
						"Question sets are maps—students follow them to mastery.",
						"Behind every set is a strategy to empower learners.",
						"Teaching is designing moments of challenge and clarity.",
						"A thoughtful question set is a teacher’s silent dialogue with students."));
		return seeQuestionSetQuotes;
	}

	public static ArrayList<String> getCreateQuestion() {
		ArrayList<String> createQuestionQuotes = new ArrayList<>(Arrays.asList(
				"Crafting a question is crafting a path to discovery.",
				"A well-designed question teaches more than a lecture.",
				"The best questions challenge, inspire, and illuminate.",
				"Creating questions is where pedagogy meets creativity.",
				"Every question you create plants a seed of learning.", "Design with purpose—ask with impact.",
				"A teacher’s question can shape a student’s future.", "Questions are the tools of transformation.",
				"To ask the right question is to teach twice.", "Great questions don’t just test—they teach."));
		return createQuestionQuotes;
	}

	public static ArrayList<String> getCreateExam() {
		ArrayList<String> createExamQuotes = new ArrayList<>(Arrays.asList(
				"An exam is not just a test—it’s a mirror of what we’ve taught.",
				"Design assessments that challenge minds, not just memory.",
				"A well-crafted exam reveals both knowledge and curiosity.",
				"Exams should measure understanding, not just recall.",
				"Creating exams is an art—balance rigor with relevance.", "The best exams teach while they test.",
				"Every question in an exam is a chance to reinforce learning.", "Assessment is a tool—not a judgment.",
				"A thoughtful exam empowers students to reflect and grow.",
				"Exams are not obstacles—they’re opportunities to shine."));
		return createExamQuotes;
	}

	static Random random = new Random();

	public static String getQ(QuoteCategory qc) {
		String q = "";
		int rnd = 0;
		if (qc == QuoteCategory.CREATE_QUESTION) {
			q = getCreateQuestion().get(random.nextInt(10));
		} else if (qc == QuoteCategory.SEE_QUESTION) {
			q = getShowQuestion().get(random.nextInt(10));
		} else if (qc == QuoteCategory.SEE_QUESTION_SET) {
			q = getShowQuestionSet().get(random.nextInt(10));
		}else if (qc == QuoteCategory.CREATE_EXAM) {
			q = getCreateExam().get(random.nextInt(10));
		}

		return q;
	}

}
