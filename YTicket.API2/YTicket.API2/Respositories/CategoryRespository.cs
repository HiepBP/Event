using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using YTicket.API2.DTO;
using YTicket.API2.Models;
using YTicket.API2.Models.DTO;
using YTicket.API2.Utils;

namespace YTicket.API2.Respositories
{
    public class CategoryRespository :
        GenericRespository<EventEntities, Category>, ICategoryRespository
    {
        private static int TotalResults;

        public IEnumerable<CategoryDTO> GetAllPaging(int pageNumber, int pageSize)
        {
            var categories = Context.Categories.Select(p => new CategoryDTO
            {
                ID = p.ID,
                Name = p.Name
            })
            .OrderBy(o => o.ID);

            TotalResults = categories.Count();

            return categories.ToPagedList(pageNumber, pageSize);
        }

        public IEnumerable<CategoryDTO> GetByNamePaging(string name, int pageNumber, int pageSize)
        {
            var categories = Context.Categories.Where(p => p.Name.Contains(name))
                .Select(p => new CategoryDTO
                {
                    ID = p.ID,
                    Name = p.Name
                })
                .OrderBy(o => o.ID);

            TotalResults = categories.Count();

            return categories.ToPagedList(pageNumber, pageSize);
        }

        public int GetTotalResults()
        {
            return TotalResults;
        }
    }

    public interface ICategoryRespository : IGenericRespository<Category>
    {
        IEnumerable<CategoryDTO> GetAllPaging(int pageNumber, int pageSize);
        IEnumerable<CategoryDTO> GetByNamePaging(string name, int pageNumber, int pageSize);
        int GetTotalResults();
    }
}