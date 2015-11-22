module CoreExtensions
  module Hash
    def method_missing(sym,*)
      fetch(sym){fetch(sym.to_s){nil}}
    end
  end
end

Hash.include CoreExtensions::Hash