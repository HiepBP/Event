using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using YTicket.API2.DTO;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Respositories;

namespace YTicket.API2.Services
{
    public class CategoryService : ICategoryService
    {
        private ICategoryRespository _respository;

        private static int TotalResults;

        public CategoryService(ICategoryRespository respository)
        {
            _respository = respository;
        }

        public IEnumerable<CategoryDTO> GetAll()
        {
            var list = _respository.GetAll();
            TotalResults = _respository.GetTotalResults();
            return list;
        }

        public IEnumerable<CategoryDTO> GetAllPaging(int pageNumber, int pageSize)
        {
            var list = _respository.GetAllPaging(pageNumber, pageSize);
            TotalResults = _respository.GetTotalResults();
            return list;
        }

        public IEnumerable<CategoryDTO> GetByNamePaging(string name, int pageNumber, int pageSize)
        {
            var list = _respository.GetByNamePaging(name, pageNumber, pageSize);
            TotalResults = _respository.GetTotalResults();
            return list;
        }

        public int GetTotalResults()
        {
            return TotalResults;
        }

    }

    public interface ICategoryService
    {
        IEnumerable<CategoryDTO> GetAll();
        IEnumerable<CategoryDTO> GetAllPaging(int pageNumber, int pageSize);
        IEnumerable<CategoryDTO> GetByNamePaging(string name, int pageNumber, int pageSize);
        int GetTotalResults();
    }
}