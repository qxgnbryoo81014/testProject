package _01_register.controller;

import java.io.File;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import _00_init.util.GlobalService;
import _01_register.model.MemberBean;
import _01_register.service.MemberService;
import _01_register.validator.MemberBeanValidator;



@Controller
@RequestMapping
@SessionAttributes({"checkOK"})
public class RegisterController {
	
	String rootDirectory = "d:\\images";
	String inputDataForm = "registerForm"; 
	String inputDataForm2 = "registerForm2"; 
	String forgetForm = "forgetForm";
	@Autowired
	MemberService memberService;
	
	@GetMapping("/_01_register/register")
	public String sendingEmptyForm(Model model) {
		MemberBean memberBean = new MemberBean();
		memberBean.setName("" );
		memberBean.setPassword("");
		memberBean.setPassword1("");
		memberBean.setMemberId("");
		memberBean.setAddress("");
		memberBean.setTel("");
		memberBean.setEmail("");
		model.addAttribute("memberBean", memberBean);
		return inputDataForm;
	}

	@PostMapping("/_01_register/register")
	public String processFormData(
			@ModelAttribute("memberBean") MemberBean bean,
			BindingResult result, Model model,
			HttpServletRequest request
			) {
		MemberBeanValidator validator = new MemberBeanValidator();
		validator.validate(bean, result);
		if (result.hasErrors()) {
//          ????????????????????????Spring MVC??????????????????			
//			List<ObjectError> list = result.getAllErrors();
//			for (ObjectError error : list) {
//				System.out.println("????????????" + error);
//			}
			return inputDataForm;
		}
		
		MultipartFile picture = bean.getMemberMultipartFile();
		String originalFilename = picture.getOriginalFilename();
		System.out.println(picture+"===========================");
		String ext = "";
		if (originalFilename.lastIndexOf(".") > -1) {
			ext = originalFilename.substring(originalFilename.lastIndexOf("."));
		}
		
		if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
			bean.setFileName(originalFilename);
		}
		// ??????Blob??????????????? Hibernate ???????????????
		if (picture != null && !picture.isEmpty()) {
			try {
				byte[] b = picture.getBytes();
				Blob blob = new SerialBlob(b);
				bean.setMemberImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("????????????????????????: " + e.getMessage());
			}
		}
		String password = bean.getPassword();
		password = GlobalService.getMD5Endocing(
				GlobalService.encryptString(password));
		bean.setPassword(password);
		Timestamp registerTime = new Timestamp(System.currentTimeMillis());
		bean.setRegisterTime(registerTime);
		// ?????? memberId????????????
		if (memberService.idExists(bean.getMemberId())) {
			result.rejectValue("memberId", "", "?????????????????????????????????");
			return inputDataForm;
		}
		
		try {
			memberService.saveMember(bean);
		} 
//		catch (org.hibernate.exception.ConstraintViolationException e) {
//			result.rejectValue("memberId", "", "?????????????????????????????????");
//			return inputDataForm;
//		} 
		catch (Exception ex) {
			System.out.println(ex.getClass().getName() + ", ex.getMessage()=" + ex.getMessage());
			result.rejectValue("memberId", "", "????????????????????????????????????..." + ex.getMessage());
			return inputDataForm;
		}
		// ??????????????????????????????????????????, ?????????????????????
		try {
			File imageFolder = new File(rootDirectory, "images");
			if (!imageFolder.exists())
				imageFolder.mkdirs();
			File file = new File(imageFolder, "MemberImage_" + bean.getMemberId() + ext);
			picture.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("????????????????????????: " + e.getMessage());
		}
//		return "redirect: " + request.getContextPath();
		return "redirect: ../_02_login/login";
	}
	@ModelAttribute
	public MemberBean prepareMemberBean(HttpServletRequest req) {
		MemberBean memberBean = new MemberBean();
		return memberBean;
	}
	@GetMapping(value = "/_01_register/mem/{pkey}")
	public String showDataForm(@PathVariable("pkey") Integer pkey, Model model) {
		MemberBean memberBean = memberService.get(pkey);
		model.addAttribute(memberBean);
		return inputDataForm2;
	}
	@PostMapping("/_01_register/mem/{pkey}")
	// BindingResult ???????????????@ModelAttribute?????????????????????????????????????????????????????????
	// 
	public String modify(
			@ModelAttribute("memberBean") MemberBean bean, 
			BindingResult result, 
			Model model,
			@PathVariable Integer pkey, 
			HttpServletRequest request) {
		long sizeInBytes = 0;
		InputStream is = null;
		MultipartFile productImage = bean.getMemberMultipartFile();
		String originalFilename = productImage.getOriginalFilename();
		bean.setFileName(originalFilename);
		String password = bean.getPassword();
		password = GlobalService.getMD5Endocing(
				GlobalService.encryptString(password));
		bean.setPassword(password);
		//  ??????Blob??????????????? Hibernate ???????????????
		if (productImage != null && !productImage.isEmpty() ) {
			
			try {
				byte[] b = productImage.getBytes();
				Blob blob = new SerialBlob(b);
				bean.setMemberImage(blob);
				sizeInBytes = 1;
			} catch(Exception e) {
				e.printStackTrace();
				throw new RuntimeException("????????????????????????: " + e.getMessage());
			}
		}else {
			sizeInBytes = -1;
		}
//		
		
		memberService.updateMember(bean,sizeInBytes);
		return "redirect:/_01_register/mem/{pkey}";
	}
	
	@ModelAttribute
	public void getMember(@PathVariable(value="pkey", required = false ) Integer pkey, Model model) {
		System.out.println("@ModelAttribute.getMember()...");
		if (pkey != null) {
			MemberBean memberBean = memberService.get(pkey);
			model.addAttribute("memberBean", memberBean);
			System.out.println("@ModelAttribute.getMember()...111");

		} else {
			MemberBean memberBean = new MemberBean();
			memberBean.setLogin("false");
			model.addAttribute("memberBean", memberBean);
			
			System.out.println("@ModelAttribute.getMember()...222");

		}
	}
	
	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "Male");
		genderMap.put("F", "Female");
		model.addAttribute("genderMap", genderMap);
	}
	
	@GetMapping("/updatepwd/pwd")
	public String getPassword(HttpServletRequest request, Model model,  String email, String tel ) {
			
		MemberBean bean = new MemberBean(email, tel);

		model.addAttribute(bean);		
		return forgetForm;
	}
	@GetMapping("/clearcheckOK")
	public String clearcheckOK(HttpSession session,  Model model, SessionStatus status, HttpServletRequest req) {
		String name = "";
		MemberBean memberBean = (MemberBean) session.getAttribute("checkOK");
		if (memberBean != null) {
			name = memberBean.getName();
		}
//		model.addAttribute("memberName", name);
		status.setComplete();
		session.invalidate();
		return null;
	}
	@PostMapping("/updatepwd/pwd")
	public String checkAccount2(
//			Imovie/updatepwd/pwd
			@ModelAttribute("memberBean") MemberBean bean,
			BindingResult result, Model model,
			HttpServletRequest request, HttpServletResponse response) {
//		System.out.println("12315645665");
//		LoginBeanValidator validator = new LoginBeanValidator();
//		validator.validate(bean, result);
//		if (result.hasErrors()) {
//			System.out.println("44444444444");
//
//			return forgetForm;
//		}
		System.out.println("333333333333");

		String password =bean.getPassword();
		MemberBean mb = null;
		try {
			// ?????? loginService????????? checkIDPassword()?????????userid???password????????????
			mb = memberService.checkMailTel(bean.getEmail(), bean.getTel());
			if (mb != null) {
				// OK, ????????????, ???mb????????????Session???????????????????????????"LoginOK"
				System.out.println("????????????????????????????????????????????????");
				model.addAttribute("checkOK", mb);
				memberService.updatePassword(mb);
				System.out.println("????????????????????????????????????????????????aaaaaaaaaa");

			} else {
				// NG, ????????????, userid?????????????????????????????????????????????????????? errorMsgMap ??????
				System.out.println("gGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
//				result.rejectValue("invalidCredentials", "", "???Email????????????????????????");
				model.addAttribute("error", "???Email????????????????????????");
				return forgetForm;
			}
		} catch (RuntimeException ex) {
			result.rejectValue("userId", "", ex.getMessage());
			return forgetForm;
		}
		HttpSession session = request.getSession();
//		System.out.println("@PostMapping(\"/login\"), session.isNew()=" + session.isNew() + ", requestURI=" + session.getAttribute("requestURI"));
//		processCookies(bean, request, response);
		String nextPath = (String)session.getAttribute("requestURI");
		if (nextPath == null) {
			nextPath = request.getContextPath();
		}
		//model.addAttribute("error", "???Email????????????????????????");
		
		return "redirect: ../_02_login/login";
	}	
}
