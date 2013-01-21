// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.coursemanager.jsf;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.el.ELContext;
import javax.el.ExpressionFactory;
import javax.faces.application.Application;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.component.html.HtmlOutputText;
import javax.faces.component.html.HtmlPanelGrid;
import javax.faces.context.FacesContext;
import javax.faces.convert.DateTimeConverter;
import org.primefaces.component.autocomplete.AutoComplete;
import org.primefaces.component.calendar.Calendar;
import org.primefaces.component.message.Message;
import org.primefaces.component.outputlabel.OutputLabel;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;
import org.rooinaction.coursemanager.jsf.OfferingBean;
import org.rooinaction.coursemanager.jsf.converter.CourseConverter;
import org.rooinaction.coursemanager.jsf.converter.InstructorConverter;
import org.rooinaction.coursemanager.jsf.util.MessageFactory;
import org.rooinaction.coursemanager.model.Course;
import org.rooinaction.coursemanager.model.Instructor;
import org.rooinaction.coursemanager.model.Offering;
import org.rooinaction.coursemanager.model.Registration;

privileged aspect OfferingBean_Roo_ManagedBean {
    
    declare @type: OfferingBean: @ManagedBean(name = "offeringBean");
    
    declare @type: OfferingBean: @SessionScoped;
    
    private String OfferingBean.name = "Offerings";
    
    private Offering OfferingBean.offering;
    
    private List<Offering> OfferingBean.allOfferings;
    
    private boolean OfferingBean.dataVisible = false;
    
    private List<String> OfferingBean.columns;
    
    private HtmlPanelGrid OfferingBean.createPanelGrid;
    
    private HtmlPanelGrid OfferingBean.editPanelGrid;
    
    private HtmlPanelGrid OfferingBean.viewPanelGrid;
    
    private boolean OfferingBean.createDialogVisible = false;
    
    private List<Registration> OfferingBean.selectedRegistrations;
    
    @PostConstruct
    public void OfferingBean.init() {
        columns = new ArrayList<String>();
        columns.add("runDate");
    }
    
    public String OfferingBean.getName() {
        return name;
    }
    
    public List<String> OfferingBean.getColumns() {
        return columns;
    }
    
    public List<Offering> OfferingBean.getAllOfferings() {
        return allOfferings;
    }
    
    public void OfferingBean.setAllOfferings(List<Offering> allOfferings) {
        this.allOfferings = allOfferings;
    }
    
    public String OfferingBean.findAllOfferings() {
        allOfferings = Offering.findAllOfferings();
        dataVisible = !allOfferings.isEmpty();
        return null;
    }
    
    public boolean OfferingBean.isDataVisible() {
        return dataVisible;
    }
    
    public void OfferingBean.setDataVisible(boolean dataVisible) {
        this.dataVisible = dataVisible;
    }
    
    public HtmlPanelGrid OfferingBean.getCreatePanelGrid() {
        if (createPanelGrid == null) {
            createPanelGrid = populateCreatePanel();
        }
        return createPanelGrid;
    }
    
    public void OfferingBean.setCreatePanelGrid(HtmlPanelGrid createPanelGrid) {
        this.createPanelGrid = createPanelGrid;
    }
    
    public HtmlPanelGrid OfferingBean.getEditPanelGrid() {
        if (editPanelGrid == null) {
            editPanelGrid = populateEditPanel();
        }
        return editPanelGrid;
    }
    
    public void OfferingBean.setEditPanelGrid(HtmlPanelGrid editPanelGrid) {
        this.editPanelGrid = editPanelGrid;
    }
    
    public HtmlPanelGrid OfferingBean.getViewPanelGrid() {
        return populateViewPanel();
    }
    
    public void OfferingBean.setViewPanelGrid(HtmlPanelGrid viewPanelGrid) {
        this.viewPanelGrid = viewPanelGrid;
    }
    
    public HtmlPanelGrid OfferingBean.populateCreatePanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        OutputLabel runDateCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        runDateCreateOutput.setFor("runDateCreateInput");
        runDateCreateOutput.setId("runDateCreateOutput");
        runDateCreateOutput.setValue("Run Date:");
        htmlPanelGrid.getChildren().add(runDateCreateOutput);
        
        Calendar runDateCreateInput = (Calendar) application.createComponent(Calendar.COMPONENT_TYPE);
        runDateCreateInput.setId("runDateCreateInput");
        runDateCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.runDate}", Date.class));
        runDateCreateInput.setNavigator(true);
        runDateCreateInput.setEffect("slideDown");
        runDateCreateInput.setPattern("dd/MM/yyyy");
        runDateCreateInput.setRequired(false);
        htmlPanelGrid.getChildren().add(runDateCreateInput);
        
        Message runDateCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        runDateCreateInputMessage.setId("runDateCreateInputMessage");
        runDateCreateInputMessage.setFor("runDateCreateInput");
        runDateCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(runDateCreateInputMessage);
        
        OutputLabel courseCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        courseCreateOutput.setFor("courseCreateInput");
        courseCreateOutput.setId("courseCreateOutput");
        courseCreateOutput.setValue("Course:");
        htmlPanelGrid.getChildren().add(courseCreateOutput);
        
        AutoComplete courseCreateInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        courseCreateInput.setId("courseCreateInput");
        courseCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.course}", Course.class));
        courseCreateInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{offeringBean.completeCourse}", List.class, new Class[] { String.class }));
        courseCreateInput.setDropdown(true);
        courseCreateInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "course", String.class));
        courseCreateInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{course.name} #{course.description} #{course.cost} #{course.maximumCapacity}", String.class));
        courseCreateInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{course}", Course.class));
        courseCreateInput.setConverter(new CourseConverter());
        courseCreateInput.setRequired(false);
        htmlPanelGrid.getChildren().add(courseCreateInput);
        
        Message courseCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        courseCreateInputMessage.setId("courseCreateInputMessage");
        courseCreateInputMessage.setFor("courseCreateInput");
        courseCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(courseCreateInputMessage);
        
        HtmlOutputText registrationsCreateOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsCreateOutput.setId("registrationsCreateOutput");
        registrationsCreateOutput.setValue("Registrations:");
        htmlPanelGrid.getChildren().add(registrationsCreateOutput);
        
        HtmlOutputText registrationsCreateInput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsCreateInput.setId("registrationsCreateInput");
        registrationsCreateInput.setValue("This relationship is managed from the Registration side");
        htmlPanelGrid.getChildren().add(registrationsCreateInput);
        
        Message registrationsCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        registrationsCreateInputMessage.setId("registrationsCreateInputMessage");
        registrationsCreateInputMessage.setFor("registrationsCreateInput");
        registrationsCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(registrationsCreateInputMessage);
        
        OutputLabel instructorCreateOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        instructorCreateOutput.setFor("instructorCreateInput");
        instructorCreateOutput.setId("instructorCreateOutput");
        instructorCreateOutput.setValue("Instructor:");
        htmlPanelGrid.getChildren().add(instructorCreateOutput);
        
        AutoComplete instructorCreateInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        instructorCreateInput.setId("instructorCreateInput");
        instructorCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.instructor}", Instructor.class));
        instructorCreateInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{offeringBean.completeInstructor}", List.class, new Class[] { String.class }));
        instructorCreateInput.setDropdown(true);
        instructorCreateInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "instructor", String.class));
        instructorCreateInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{instructor.firstName} #{instructor.middleNameOrInitial} #{instructor.lastName} #{instructor.addressLine1}", String.class));
        instructorCreateInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{instructor}", Instructor.class));
        instructorCreateInput.setConverter(new InstructorConverter());
        instructorCreateInput.setRequired(false);
        htmlPanelGrid.getChildren().add(instructorCreateInput);
        
        Message instructorCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        instructorCreateInputMessage.setId("instructorCreateInputMessage");
        instructorCreateInputMessage.setFor("instructorCreateInput");
        instructorCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(instructorCreateInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid OfferingBean.populateEditPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        OutputLabel runDateEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        runDateEditOutput.setFor("runDateEditInput");
        runDateEditOutput.setId("runDateEditOutput");
        runDateEditOutput.setValue("Run Date:");
        htmlPanelGrid.getChildren().add(runDateEditOutput);
        
        Calendar runDateEditInput = (Calendar) application.createComponent(Calendar.COMPONENT_TYPE);
        runDateEditInput.setId("runDateEditInput");
        runDateEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.runDate}", Date.class));
        runDateEditInput.setNavigator(true);
        runDateEditInput.setEffect("slideDown");
        runDateEditInput.setPattern("dd/MM/yyyy");
        runDateEditInput.setRequired(false);
        htmlPanelGrid.getChildren().add(runDateEditInput);
        
        Message runDateEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        runDateEditInputMessage.setId("runDateEditInputMessage");
        runDateEditInputMessage.setFor("runDateEditInput");
        runDateEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(runDateEditInputMessage);
        
        OutputLabel courseEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        courseEditOutput.setFor("courseEditInput");
        courseEditOutput.setId("courseEditOutput");
        courseEditOutput.setValue("Course:");
        htmlPanelGrid.getChildren().add(courseEditOutput);
        
        AutoComplete courseEditInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        courseEditInput.setId("courseEditInput");
        courseEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.course}", Course.class));
        courseEditInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{offeringBean.completeCourse}", List.class, new Class[] { String.class }));
        courseEditInput.setDropdown(true);
        courseEditInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "course", String.class));
        courseEditInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{course.name} #{course.description} #{course.cost} #{course.maximumCapacity}", String.class));
        courseEditInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{course}", Course.class));
        courseEditInput.setConverter(new CourseConverter());
        courseEditInput.setRequired(false);
        htmlPanelGrid.getChildren().add(courseEditInput);
        
        Message courseEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        courseEditInputMessage.setId("courseEditInputMessage");
        courseEditInputMessage.setFor("courseEditInput");
        courseEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(courseEditInputMessage);
        
        HtmlOutputText registrationsEditOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsEditOutput.setId("registrationsEditOutput");
        registrationsEditOutput.setValue("Registrations:");
        htmlPanelGrid.getChildren().add(registrationsEditOutput);
        
        HtmlOutputText registrationsEditInput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsEditInput.setId("registrationsEditInput");
        registrationsEditInput.setValue("This relationship is managed from the Registration side");
        htmlPanelGrid.getChildren().add(registrationsEditInput);
        
        Message registrationsEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        registrationsEditInputMessage.setId("registrationsEditInputMessage");
        registrationsEditInputMessage.setFor("registrationsEditInput");
        registrationsEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(registrationsEditInputMessage);
        
        OutputLabel instructorEditOutput = (OutputLabel) application.createComponent(OutputLabel.COMPONENT_TYPE);
        instructorEditOutput.setFor("instructorEditInput");
        instructorEditOutput.setId("instructorEditOutput");
        instructorEditOutput.setValue("Instructor:");
        htmlPanelGrid.getChildren().add(instructorEditOutput);
        
        AutoComplete instructorEditInput = (AutoComplete) application.createComponent(AutoComplete.COMPONENT_TYPE);
        instructorEditInput.setId("instructorEditInput");
        instructorEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.instructor}", Instructor.class));
        instructorEditInput.setCompleteMethod(expressionFactory.createMethodExpression(elContext, "#{offeringBean.completeInstructor}", List.class, new Class[] { String.class }));
        instructorEditInput.setDropdown(true);
        instructorEditInput.setValueExpression("var", expressionFactory.createValueExpression(elContext, "instructor", String.class));
        instructorEditInput.setValueExpression("itemLabel", expressionFactory.createValueExpression(elContext, "#{instructor.firstName} #{instructor.middleNameOrInitial} #{instructor.lastName} #{instructor.addressLine1}", String.class));
        instructorEditInput.setValueExpression("itemValue", expressionFactory.createValueExpression(elContext, "#{instructor}", Instructor.class));
        instructorEditInput.setConverter(new InstructorConverter());
        instructorEditInput.setRequired(false);
        htmlPanelGrid.getChildren().add(instructorEditInput);
        
        Message instructorEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        instructorEditInputMessage.setId("instructorEditInputMessage");
        instructorEditInputMessage.setFor("instructorEditInput");
        instructorEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(instructorEditInputMessage);
        
        return htmlPanelGrid;
    }
    
    public HtmlPanelGrid OfferingBean.populateViewPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();
        
        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);
        
        HtmlOutputText runDateLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        runDateLabel.setId("runDateLabel");
        runDateLabel.setValue("Run Date:");
        htmlPanelGrid.getChildren().add(runDateLabel);
        
        HtmlOutputText runDateValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        runDateValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.runDate}", Date.class));
        DateTimeConverter runDateValueConverter = (DateTimeConverter) application.createConverter(DateTimeConverter.CONVERTER_ID);
        runDateValueConverter.setPattern("dd/MM/yyyy");
        runDateValue.setConverter(runDateValueConverter);
        htmlPanelGrid.getChildren().add(runDateValue);
        
        HtmlOutputText courseLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        courseLabel.setId("courseLabel");
        courseLabel.setValue("Course:");
        htmlPanelGrid.getChildren().add(courseLabel);
        
        HtmlOutputText courseValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        courseValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.course}", Course.class));
        courseValue.setConverter(new CourseConverter());
        htmlPanelGrid.getChildren().add(courseValue);
        
        HtmlOutputText registrationsLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsLabel.setId("registrationsLabel");
        registrationsLabel.setValue("Registrations:");
        htmlPanelGrid.getChildren().add(registrationsLabel);
        
        HtmlOutputText registrationsValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        registrationsValue.setId("registrationsValue");
        registrationsValue.setValue("This relationship is managed from the Registration side");
        htmlPanelGrid.getChildren().add(registrationsValue);
        
        HtmlOutputText instructorLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        instructorLabel.setId("instructorLabel");
        instructorLabel.setValue("Instructor:");
        htmlPanelGrid.getChildren().add(instructorLabel);
        
        HtmlOutputText instructorValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        instructorValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{offeringBean.offering.instructor}", Instructor.class));
        instructorValue.setConverter(new InstructorConverter());
        htmlPanelGrid.getChildren().add(instructorValue);
        
        return htmlPanelGrid;
    }
    
    public Offering OfferingBean.getOffering() {
        if (offering == null) {
            offering = new Offering();
        }
        return offering;
    }
    
    public void OfferingBean.setOffering(Offering offering) {
        this.offering = offering;
    }
    
    public List<Course> OfferingBean.completeCourse(String query) {
        List<Course> suggestions = new ArrayList<Course>();
        for (Course course : Course.findAllCourses()) {
            String courseStr = String.valueOf(course.getName() +  " "  + course.getDescription() +  " "  + course.getCost() +  " "  + course.getMaximumCapacity());
            if (courseStr.toLowerCase().startsWith(query.toLowerCase())) {
                suggestions.add(course);
            }
        }
        return suggestions;
    }
    
    public List<Registration> OfferingBean.getSelectedRegistrations() {
        return selectedRegistrations;
    }
    
    public void OfferingBean.setSelectedRegistrations(List<Registration> selectedRegistrations) {
        if (selectedRegistrations != null) {
            offering.setRegistrations(new HashSet<Registration>(selectedRegistrations));
        }
        this.selectedRegistrations = selectedRegistrations;
    }
    
    public List<Instructor> OfferingBean.completeInstructor(String query) {
        List<Instructor> suggestions = new ArrayList<Instructor>();
        for (Instructor instructor : Instructor.findAllInstructors()) {
            String instructorStr = String.valueOf(instructor.getFirstName() +  " "  + instructor.getMiddleNameOrInitial() +  " "  + instructor.getLastName() +  " "  + instructor.getAddressLine1());
            if (instructorStr.toLowerCase().startsWith(query.toLowerCase())) {
                suggestions.add(instructor);
            }
        }
        return suggestions;
    }
    
    public String OfferingBean.onEdit() {
        if (offering != null && offering.getRegistrations() != null) {
            selectedRegistrations = new ArrayList<Registration>(offering.getRegistrations());
        }
        return null;
    }
    
    public boolean OfferingBean.isCreateDialogVisible() {
        return createDialogVisible;
    }
    
    public void OfferingBean.setCreateDialogVisible(boolean createDialogVisible) {
        this.createDialogVisible = createDialogVisible;
    }
    
    public String OfferingBean.displayList() {
        createDialogVisible = false;
        findAllOfferings();
        return "offering";
    }
    
    public String OfferingBean.displayCreateDialog() {
        offering = new Offering();
        createDialogVisible = true;
        return "offering";
    }
    
    public String OfferingBean.persist() {
        String message = "";
        if (offering.getId() != null) {
            offering.merge();
            message = "message_successfully_updated";
        } else {
            offering.persist();
            message = "message_successfully_created";
        }
        RequestContext context = RequestContext.getCurrentInstance();
        context.execute("createDialogWidget.hide()");
        context.execute("editDialogWidget.hide()");
        
        FacesMessage facesMessage = MessageFactory.getMessage(message, "Offering");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllOfferings();
    }
    
    public String OfferingBean.delete() {
        offering.remove();
        FacesMessage facesMessage = MessageFactory.getMessage("message_successfully_deleted", "Offering");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllOfferings();
    }
    
    public void OfferingBean.reset() {
        offering = null;
        selectedRegistrations = null;
        createDialogVisible = false;
    }
    
    public void OfferingBean.handleDialogClose(CloseEvent event) {
        reset();
    }
    
}