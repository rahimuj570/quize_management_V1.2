package helper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class Quotes {

	public static enum QuoteCategory {
		SEE_QUESTION, CREATE_QUESTION, SEE_QUESTION_SET, CREATE_EXAM, PENDING_USERS, TEACHER, STUDENT, ADMIN;
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

	public static ArrayList<String> getPendingUsers() {
		ArrayList<String> approvalQuotes = new ArrayList<>(Arrays.asList(
				"Empowering a teacher means unlocking a thousand minds.",
				"Every approved student is a step toward a brighter future.",
				"Admins hold the key to a thriving learning community.",
				"Behind every approval is a story waiting to unfold.", "Teachers shape generations—choose wisely.",
				"Students seek knowledge; admins open the door.",
				"Approving the right people builds trust and excellence.",
				"Admins don’t just approve—they elevate potential.",
				"A single click can launch a lifetime of learning.", "Great education begins with great decisions."));
		return approvalQuotes;
	}

	public static ArrayList<String> getTeacher() {
		ArrayList<String> showTeacherQuotes = new ArrayList<>(Arrays.asList(
				"A good teacher can inspire hope, ignite the imagination, and instill a love of learning. – Brad Henry",
				"Teaching is the one profession that creates all other professions. – Unknown",
				"The influence of a great teacher can never be erased. – Unknown",
				"Teachers plant seeds of knowledge that grow forever. – Unknown",
				"It is the supreme art of the teacher to awaken joy in creative expression and knowledge. – Albert Einstein",
				"A teacher takes a hand, opens a mind, and touches a heart. – Unknown",
				"What the teacher is, is more important than what they teach. – Karl Menninger",
				"Teachers don’t just teach—they inspire, guide, and shape futures. – Unknown",
				"Behind every successful person is a teacher who believed in them. – Unknown",
				"To teach is to touch a life forever. – Unknown"));
		return showTeacherQuotes;
	}

	public static ArrayList<String> getStudent() {
		ArrayList<String> studentQuotes = new ArrayList<>(Arrays.asList(
				"Education is the passport to the future, for tomorrow belongs to those who prepare for it today. – Malcolm X",
				"The expert in anything was once a beginner. – Helen Hayes",
				"Success is the sum of small efforts, repeated day in and day out. – Robert Collier",
				"Don’t let what you cannot do interfere with what you can do. – John Wooden",
				"Learning is not attained by chance; it must be sought for with ardor and attended to with diligence. – Abigail Adams",
				"Push yourself, because no one else is going to do it for you. – Unknown",
				"The beautiful thing about learning is that no one can take it away from you. – B.B. King",
				"Your education is a dress rehearsal for a life that is yours to lead. – Nora Ephron",
				"It always seems impossible until it’s done. – Nelson Mandela",
				"Believe you can and you're halfway there. – Theodore Roosevelt"));
		return studentQuotes;
	}

	public static ArrayList<String> getAdmin() {
		return new ArrayList<>(Arrays.asList("Leadership is not about power—it’s about responsibility.",
				"Every decision shapes the future. Choose with integrity.",
				"Fairness is the foundation of trust in any system.",
				"Approving excellence is easy—rejecting mediocrity takes courage.",
				"A good manager empowers both teachers and students to grow.",
				"Behind every approval is a belief in potential.", "Reject not the person, but the lack of readiness.",
				"True leadership listens before it decides.",
				"Managing education means managing futures—handle with care.",
				"Balance empathy with standards, and you'll lead wisely."));
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
		} else if (qc == QuoteCategory.CREATE_EXAM) {
			q = getCreateExam().get(random.nextInt(10));
		} else if (qc == QuoteCategory.PENDING_USERS) {
			q = getPendingUsers().get(random.nextInt(10));
		} else if (qc == QuoteCategory.TEACHER) {
			q = getTeacher().get(random.nextInt(10));
		} else if (qc == QuoteCategory.STUDENT) {
			q = getStudent().get(random.nextInt(10));
		} else if (qc == QuoteCategory.ADMIN) {
			q = getAdmin().get(random.nextInt(10));
		}

		return q;
	}

}
