class TestsController < ApplicationController

  def show_marked
    @tests = Test.all
    if params[:user]
      user = params[:user]
      @tests = Test.all
      @marked = Test.find(:all, :conditions => { :marked => true })
      render :partial => 'show_marked', :layout => false
    end
  end
  
  def inc_search
    if params[:marked]
      user = params[:marked]
      puts "************ "
      puts params[:marked]
        @optional = true
        if params[:optional] == "Do not"       
          @optional = false
        end
      case user
      when "All" 
        @tests = Test.all
      when "Marked"
        @tests = Test.find(:all, :conditions => { :marked => true })
      else
        @tests = Test.find(:all, :conditions => { :marked => false })
      end
      @marked = Test.find(:all, :conditions => { :marked => true })
      render :partial => 'index_all', :layout => false
    end
  end

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/new
  # GET /tests/new.json
  def new
    @test = Test.new
    @test.marked = false  # specified in assignment

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test }
    end

  end

  # POST /tests
  # POST /tests.json
#  def create
#    @test = Test.new(params[:test])

#    respond_to do |format|
#      if @test.save
#        format.html { redirect_to @test, notice: 'Test was successfully created.' }
#        format.json { render json: @test, status: :created, location: @test }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @test.errors, status: :unprocessable_entity }
#      end
#    end
#  end

respond_to :html, :xml, :json

def create
  @test = Test.new( params[:test] )

  if @test.save
    respond_with do |format|
      format.html do
        if request.xhr?
          render :partial => "tests/show", :layout => false, :status => :created
        else
          redirect_to @test
        end
      end
    end
  else
    respond_with do |format|
      format.html do
        if request.xhr?
          render :json => @test.errors, :status => :unprocessable_entity
        else
          render :action => :new, :status => :unprocessable_entity
        end
      end
    end
  end
end




  # PUT /tests/1
  # PUT /tests/1.json
  def update
    @test = Test.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
      format.json { head :ok }
      format.js { render :nothing => true }
    end
  end
end
